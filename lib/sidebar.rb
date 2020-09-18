# frozen_string_literal: false

require 'jekyll'
require 'nokogiri'
require 'json'
require_relative 'active'
require_relative 'safe_merge'
require_relative 'sanitized'
require_relative 'sidebar_builder'

module SwedbankPay
  # A nice sidebar
  class Sidebar
    def initialize
      @pages_pre_render = {}
      @pages_with_headers = {}
    end

    def pre_render(page)
      menu_order = page['menu_order'].nil? ? 0 : page['menu_order']
      hide_from_sidebar = page['hide_from_sidebar'].nil? ? false : page['hide_from_sidebar']
      url = page['url'].gsub('index.html', '').gsub('.html', '')
      @pages_pre_render[url] = {
        title: page['title'],
        url: page['url'].gsub('.html', ''),
        name: page['name'],
        menu_order: menu_order,
        hide_from_sidebar: hide_from_sidebar
      }
    end

    def post_write(site)
      files = parse_files(site)
      write_sidebar_to_files(files)
    end

    private

    def parse_files(site)
      files = []
      destination = site.config['destination']
      Dir.glob("#{destination}/**/*.html") do |filename|
        doc = File.open(filename) { |f| Nokogiri::HTML(f) }
        sanitized_filename = filename.sanitized

        files.push(
          {
            filename: filename,
            sanitized_filename: sanitized_filename,
            doc: doc
          }
        )

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

        @pages_with_headers[sanitized_filename] = { headers: headers }
      end

      files
    end

    def write_sidebar_to_files(files)
      files.each do |file|
        sanitized_filename = file[:sanitized_filename]
        filename = file[:filename]
        doc = file[:doc]
        sidebar_markup = nil

        begin
          sidebar_markup = render(sanitized_filename)
        rescue StandardError => e
          Jekyll.logger.error("           Sidebar: Unable to render sidebar for '#{filename}'.")
          Jekyll.logger.debug("           Sidebar: #{e.message}. #{e.backtrace.inspect}")
          next
        end

        sidebar_containers = doc.xpath('//*[@id="dx-sidebar-main-nav-ul"]')

        unless sidebar_containers.any?
          Jekyll.logger.debug("           Sidebar: No sidebar container found in #{filename}")
          next
        end

        sidebar_containers.each do |sidebar_container|
          sidebar_container.inner_html = sidebar_markup
        end

        Jekyll.logger.debug("   Writing Sidebar: #{filename}")
        File.open(filename, 'w') { |f| f.write(doc.to_html(encoding: 'UTF-8')) }
      end
    end

    def render(filename)
      sidebar_markup = ''
      pages = @pages_pre_render \
              .safe_merge(@pages_with_headers) \
              .sort_by { |_, page| page[:menu_order] }

      builder = SidebarBuilder.new(filename, pages)
      sidebar_markup = builder.build

      File.open('_site/sidebar.html', 'w') { |f| f.write(sidebar_markup) }
      sidebar_markup
    end
  end
end

sidebar = SwedbankPay::Sidebar.new

Jekyll::Hooks.register :site, :pre_render do |site, _payload|
  site.pages.each do |page|
    sidebar.pre_render page
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  sidebar.post_write site
end
