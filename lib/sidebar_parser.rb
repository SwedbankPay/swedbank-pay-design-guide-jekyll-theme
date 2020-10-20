# frozen_string_literal: true

require_relative 'sidebar_path'

module SwedbankPay
  # The Sidebar renderer
  class SidebarParser
    def initialize(site)
      @site = site
    end

    def parse(pages)
      destination = @site.config['destination']

      Dir.glob("#{destination}/**/*.html") do |filename|
        doc = File.open(filename) { |f| Nokogiri::HTML(f) }
        path = SidebarPath.new(filename).to_s
        page = pages[path]

        page.doc = doc
        page.filename = filename
        page.headers = find_headers(doc)
        page.sidebar_container = find_sidebar_container(filename, doc)
      end

      pages
    end

    private

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

    def find_sidebar_container(filename, doc)
      sidebar_containers = doc.xpath('//*[@id="dx-sidebar-main-nav-ul"]')

      unless sidebar_containers.any?
        Jekyll.logger.debug("           Sidebar: No sidebar container found in #{filename}")
        return nil
      end

      sidebar_containers.first
    end
  end
end
