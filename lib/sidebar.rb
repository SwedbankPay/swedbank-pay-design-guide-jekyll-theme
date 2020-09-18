# frozen_string_literal: false

require 'jekyll'
require 'nokogiri'
require 'json'
require_relative 'active'
require_relative 'safe_merge'
require_relative 'sanitized'

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
          Jekyll.logger.error("           Sidebar: Unable to render sidebar_markup for '#{filename}'.")
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
      pages = @pages_pre_render.safe_merge(@pages_with_headers).sort_by { |_, page| page[:menu_order] }

      pages.select { |path, _| path.split('/').length <= 2 }.each do |path, page|
        next if page[:title].nil?
        next if page[:hide_from_sidebar]

        title = page[:title].split('–').first
        child_pages = pages.select { |child_path, _| child_path.include?(path) && child_path != path && path != '/' }

        active = filename.active?(path)
        # puts "#{filename}, #{path}" if active
        item_class = active ? 'nav-group active' : 'nav-group'

        child_markup = "<li class=\"#{item_class}\">"
        child_markup << '<div class="nav-group-heading">'
        child_markup << '<i class="material-icons">arrow_right</i>'
        child_markup << "<span>#{title}</span></div>"

        child_markup << '<ul class="nav-ul">'

        sub_group_markup = generate_sub_group(filename, path, page, child_pages, 2)

        child_markup << sub_group_markup unless sub_group_markup.nil?

        if child_pages.any?
          child_pages.select { |child_path, _| child_path.split('/').length <= 3 }.each do |child_path, child_page|
            next if child_page[:title].nil?
            next if child_page[:hide_from_sidebar]

            sub_group_markup = generate_sub_group(filename, child_path, child_page, child_pages, 2)
            child_markup << sub_group_markup unless sub_group_markup.nil?
          end
        end

        child_markup << '</ul>'
        child_markup << '</li>'
        sidebar_markup << child_markup
      end

      File.open('_site/sidebar.html', 'w') { |f| f.write(sidebar_markup) }
      sidebar_markup
    end

    def generate_sub_group(filename, path, page, all_child_pages, level)
      title = page[:title].split('–').last.strip

      url = page[:url]
      headers = page[:headers]

      grandchildren = all_child_pages.select do |grandchild_path, _|
        grandchild_path.include?(path) \
        && grandchild_path != path \
        && path.split('/').length > level
      end

      sub_group_markup = ''
      has_child_pages = !all_child_pages.empty?

      if (!headers.nil? && headers.any?) || !grandchildren.empty?
        if has_child_pages
          active = filename.active?(url, exact: true)
          item_class = active || (url.split('/').length > level && filename.start_with?(url)) ? 'nav-subgroup active' : 'nav-subgroup'
          sub_group_markup << "<li class=\"#{item_class}\">"
          sub_group_markup << '<div class="nav-subgroup-heading">'
          sub_group_markup << '<i class="material-icons">arrow_right</i>'
          sub_group_markup << "<a href=\"#{url}\">#{title}</a>"
          sub_group_markup << '</div>'
          sub_group_markup << '<ul class="nav-ul">'

          if grandchildren.empty?
            headers.each do |header|
              hash = header[:hash]
              subtitle = header[:title]
              sub_group_markup << "<li class=\"nav-leaf\"><a href=\"#{url}#{hash}\">#{subtitle}</a></li>"
            end
          else
            sub_group_leaf_class = active ? 'nav-leaf nav-subgroup-leaf active' : 'nav-leaf nav-subgroup-leaf'
            sub_group_markup << "<li class=\"#{sub_group_leaf_class}\"><a href=\"#{url}\">#{title} overview</a></li>"

            grandchildren.each do |grandchild_path, grandchild_page|
              sub_group_markup << generate_sub_group(filename, grandchild_path, grandchild_page, grandchildren, 3)
            end
          end

          sub_group_markup << '</ul>'
          sub_group_markup << '</li>'
        else
          headers.each do |header|
            hash = header[:hash]
            subtitle = header[:title]
            sub_group_markup << "<li class=\"nav-leaf\"><a href=\"#{url}#{hash}\">#{subtitle}</a></li>"
          end
        end
      else
        sub_group_markup << if has_child_pages
                              "<li class=\"nav-leaf nav-subgroup-leaf\"><a href=\"#{url}\">#{title}</a></li>"
                            else
                              "<li class=\"nav-leaf\"><a href=\"#{url}\">#{title}</a></li>"
                            end
      end

      sub_group_markup
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
