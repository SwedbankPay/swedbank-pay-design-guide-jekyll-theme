# frozen_string_literal: false

require 'jekyll'
require 'nokogiri'
require 'json'
require_relative 'active'
require_relative 'safe_merge'
require_relative 'sanitized'

module Jekyll
  # A nice sidebar
  class Sidebar
    attr_accessor :hash_pre_render
    attr_accessor :filename_with_headers

    def initialize
      @hash_pre_render = {}
      @filename_with_headers = {}
    end

    def pre_render(page)
      menu_order = page['menu_order'].nil? ? 0 : page['menu_order']
      hide_from_sidebar = page['hide_from_sidebar'].nil? ? false : page['hide_from_sidebar']
      url = page['url'].gsub('index.html', '').gsub('.html', '')
      @hash_pre_render[url] = {
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

          child = header.last_element_child
          header = {
            id: header['id'],
            title: header.content.strip,
            hash: (child['href']).to_s
          }
          headers.push(header)
        end

        @filename_with_headers[sanitized_filename] = { headers: headers }
      end

      files
    end

    def write_sidebar_to_files(files)
      files.each do |file|
        sanitized_filename = file[:sanitized_filename]
        filename = file[:filename]
        doc = file[:doc]
        sidebar = render(sanitized_filename)

        doc.xpath('//*[@id="dx-sidebar-main-nav-ul"]').each do |sidebar_container|
          sidebar_container.inner_html = sidebar
        end

        File.open(filename, 'w') { |f| f.write(doc.to_html(encoding: 'UTF-8')) }
      end
    end

    def generate_sub_group(filename, key, value, all_sub_groups, level)
      title = value[:title].split('–').last.strip
      url = value[:url]
      headers = value[:headers]

      sub_sub_group_list = all_sub_groups.select do |sub_sub_group_key, _|
        sub_sub_group_key.include? key and sub_sub_group_key != key and \
          key.split('/').length > level
      end

      sub_group = ''
      has_sub_groups = !all_sub_groups.empty?

      if headers.any? || !sub_sub_group_list.empty?
        if has_sub_groups
          active = filename.active?(url, true)
          # puts "#{url}, #{filename}, #{key}" if active
          item_class = active || (url.split('/').length > level && filename.start_with?(url)) ? 'nav-subgroup active' : 'nav-subgroup'
          sub_group << "<li class=\"#{item_class}\">"
          sub_group << "<div class=\"nav-subgroup-heading\"><i class=\"material-icons\">arrow_right</i><a href=\"#{url}\">#{title}</a></div>"
          sub_group << '<ul class="nav-ul">'

          if sub_sub_group_list.empty?
            headers.each do |header|
              hash = header[:hash]
              subtitle = header[:title]
              sub_group << "<li class=\"nav-leaf\"><a href=\"#{url}#{hash}\">#{subtitle}</a></li>"
            end
          else
            sub_group_leaf_class = active ? 'nav-leaf nav-subgroup-leaf active' : 'nav-leaf nav-subgroup-leaf'
            sub_group << "<li class=\"#{sub_group_leaf_class}\"><a href=\"#{url}\">#{title} overview</a></li>"

            sub_sub_group_list.each do |sub_sub_group_key, sub_sub_group_value|
              sub_group << generate_sub_group(filename, sub_sub_group_key, sub_sub_group_value, sub_sub_group_list, 3)
            end
          end

          sub_group << '</ul>'
          sub_group << '</li>'
        else
          headers.each do |header|
            hash = header[:hash]
            subtitle = header[:title]
            sub_group << "<li class=\"nav-leaf\"><a href=\"#{url}#{hash}\">#{subtitle}</a></li>"
          end
        end
      else
        sub_group << if has_sub_groups
                      "<li class=\"nav-leaf nav-subgroup-leaf\"><a href=\"#{url}\">#{title}</a></li>"
                    else
                      "<li class=\"nav-leaf\"><a href=\"#{url}\">#{title}</a></li>"
                    end
      end

      sub_group
    end

    def render(filename)
      sidebar = ''

      merged = @hash_pre_render.safe_merge(@filename_with_headers).sort_by { |_, value| value[:menu_order] }
      merged.select { |key, _| key.split('/').length <= 2 }.each do |key, value|
        next if value[:title].nil?
        next if value[:hide_from_sidebar]

        sub_groups = merged.select { |sub_group_key, _| sub_group_key.include? key and sub_group_key != key and key != '/' }

        active = filename.active?(key)
        # puts "#{filename}, #{key}" if active
        item_class = active ? 'nav-group active' : 'nav-group'

        child = "<li class=\"#{item_class}\">"
        child << "<div class=\"nav-group-heading\"><i class=\"material-icons\">arrow_right</i><span>#{value[:title].split('–').first}</span></div>"

        child << '<ul class="nav-ul">'

        sub_group = generate_sub_group(filename, key, value, sub_groups, 2)

        child << sub_group

        if sub_groups.any?
          sub_groups.select { |sub_group_key, _sub_group_value| sub_group_key.split('/').length <= 3 }.each do |sub_group_key, sub_group_value|
            sub_group = generate_sub_group(filename, sub_group_key, sub_group_value, sub_groups, 2)
            child << sub_group
          end
        end

        child << '</ul>'
        child << '</li>'
        sidebar << child
      end

      File.open('_site/sidebar.html', 'w') { |f| f.write(sidebar) }
      sidebar
    end
  end
end

sidebar = Jekyll::Sidebar.new

Jekyll::Hooks.register :site, :pre_render do |site, _payload|
  site.pages.each do |page|
    sidebar.pre_render page
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  sidebar.post_write site
end
