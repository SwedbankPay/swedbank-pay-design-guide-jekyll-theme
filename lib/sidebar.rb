# frozen_string_literal: false

require 'jekyll'
require 'nokogiri'
require 'json'
require_relative 'active'
require_relative 'safe_merge'
require_relative 'sidebar_page'
require_relative 'sidebar_tree_builder'

module SwedbankPay
  # A nice sidebar
  module Sidebar
    class << self
      def init
        @source_pages = {}
      end

      def pre_render(page)
        sidebar_page = SidebarPage.new(page)
        @source_pages[sidebar_page.path] = sidebar_page
      end

      def post_write(site)
        parse_files(site)

        @sidebar_pages = SidebarTreeBuilder.new(@source_pages)
        puts @sidebar_pages.inspect

        # write_sidebar_to_files(files)
      end

      def pages
        @sidebar_pages
      end

      private

      def parse_files(site)
        destination = site.config['destination']
        Dir.glob("#{destination}/**/*.html") do |filename|
          doc = File.open(filename) { |f| Nokogiri::HTML(f) }
          path = SidebarPath.new(filename).to_s

          page = @source_pages[path]

          page.doc = doc
          page.headers = find_headers(doc)
        end
      end

      def find_headers(doc)
        headers = []

        doc.xpath('//h2').each do |header|
          next unless header['id']

          child_markup = header.last_element_child
          header = {
            id: header['id'],
            title: header.content.strip,
            hash: (child_markup['href']).to_s
          }
          headers.push(header)
        end

        headers
      end

      def write_sidebar_to_files(files)
        files.each do |file|
          sanitized_filename = file[:sanitized_filename]
          filename = file[:filename]
          doc = file[:doc]
          sidebar_markup = render(sanitized_filename, pages)

          next if sidebar_markup.nil?

          sidebar_containers = find_containers(doc, filename)

          next if sidebar_containers.nil?

          sidebar_containers.each do |sidebar_container|
            sidebar_container.inner_html = sidebar_markup
          end

          Jekyll.logger.debug("   Writing Sidebar: #{filename}")
          File.open(filename, 'w') { |f| f.write(doc.to_html(encoding: 'UTF-8')) }
        end
      end

      def render(filename, pages)
        sidebar_markup = nil

        begin
          builder = SidebarBuilder.new(filename, pages)

          sidebar_markup = builder.build

          File.open('_site/sidebar.html', 'w') { |f| f.write(sidebar_markup) }
        rescue StandardError => e
          Jekyll.logger.error("           Sidebar: Unable to render sidebar for '#{filename}'.")
          Jekyll.logger.debug("           Sidebar: #{e.message}. #{e.backtrace.inspect}")
          nil
        end

        sidebar_markup
      end

      def find_containers(doc, filename)
        sidebar_containers = doc.xpath('//*[@id="dx-sidebar-main-nav-ul"]')

        unless sidebar_containers.any?
          Jekyll.logger.debug("           Sidebar: No sidebar container found in #{filename}")
          nil
        end

        sidebar_containers
      end
    end
  end
end

SwedbankPay::Sidebar.init

Jekyll::Hooks.register :site, :pre_render do |site, _|
  site.pages.each do |page|
    SwedbankPay::Sidebar.pre_render page
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  SwedbankPay::Sidebar.post_write site
end
