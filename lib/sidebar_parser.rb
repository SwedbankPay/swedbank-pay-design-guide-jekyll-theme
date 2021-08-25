# frozen_string_literal: true

require 'jekyll'
require 'jekyll-redirect-from'
require_relative 'sidebar_logger'
require_relative 'sidebar_path'

module SwedbankPay
  # The Sidebar renderer
  class SidebarParser
    attr_reader :pages

    def initialize(site)
      raise ArgumentError, 'Site cannot be nil' if site.nil?
      raise ArgumentError, 'Site must be a Jekyll::Site' unless site.is_a? Jekyll::Site

      @pages = convert(site.pages)
    end

    def parse(tree)
      raise ArgumentError, 'tree cannot be nil' if tree.nil?
      raise ArgumentError, 'tree must be a SidebarTreeBuilder' unless tree.is_a? SidebarTreeBuilder

      parse_html(tree)
    end

    private

    def convert(pages)
      pages_hash = {}

      pages.each do |jekyll_page|
        if skippable? jekyll_page
          SidebarLogger.debug("Skipping <#{jekyll_page['url']}>")
          next
        end

        sidebar_page = SidebarPage.new(jekyll_page)
        pages_hash[sidebar_page.path] = sidebar_page
      end

      pages_hash
    end

    def parse_html(pages)
      return if pages.nil? || pages.empty?

      pages.each do |page|
        page.load
        page.headers = find_headers(page)
        page.sidebar_container = find_sidebar_container(page)
        page.freeze

        parse_html(page.children)
      end

      pages
    end

    def find_headers(page)
      headers = []

      # Don't include headers in the sidebar if we're on a card overview page.
      return headers if page.card_overview? || !page.anchor_headings?

      page.doc.xpath('//h2').each do |header|
        id = header['id']

        next unless id

        child_markup = header.last_element_child
        hash = child_markup['href'].to_s if child_markup.respond_to? :[]
        title = header.content.strip

        headers.push({ id: id, title: title, hash: hash })
      end

      headers
    end

    def find_sidebar_container(page)
      sidebar_containers = page.doc.xpath('//*[@id="dx-sidebar-main-nav-ul"]')

      if sidebar_containers.empty?
        SidebarLogger.error("No sidebar container found in <#{page.filename}>!")
        return nil
      end

      sidebar_containers.first
    end

    def skippable?(jekyll_page)
      return true if jekyll_page.is_a? JekyllRedirectFrom::RedirectPage
      return true if jekyll_page.is_a? JekyllRedirectFrom::PageWithoutAFile

      false
    end
  end
end
