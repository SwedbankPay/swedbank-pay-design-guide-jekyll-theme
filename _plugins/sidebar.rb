require "jekyll"
require "nokogiri"
require "json"

module Jekyll
  class Sidebar
    attr_accessor :hash_pre_render
    attr_accessor :filename_with_headers

    def initialize
      @hash_pre_render = {}
      @filename_with_headers = {}
    end

    def pre_render(page)
      menu_order = unless page["menu-order"].nil? then page["menu-order"] else 0 end
      url = page["url"].gsub("index.html", "").gsub(".html", "")
      @hash_pre_render[url] = {
        :title => page["title"],
        :url => page["url"],
        :name => page["name"],
        :menu_order => menu_order,
      }
    end

    def post_write(site)
      files = []
      Dir.glob("#{site.config["destination"]}/**/*.html") do |filename|
        doc = File.open(filename) { |f| Nokogiri::HTML(f) }
        files.push(doc)
        title = doc.title
        url = ""
        doc.xpath("/html/head/meta").each do |meta|
          if meta.attr("property").eql? "og:url"
            url = meta.attr("value")
          end
        end

        headers = []
        doc.xpath("//h1 | //h2 | //h2 | //h3 | //h4 | //h5 | //h6").each do |header|
          if not header["id"]
            next
          end
          child = header.last_element_child
          header = {
            :id => header["id"],
            :title => header.content.strip,
            :url => "#{url}#{child["href"]}",
          }
          headers.push(header)
        end
        sanitized_filename = filename.match(/(?m)(?<=\b_site).*$/)[0]
        sanitized_filename = sanitized_filename.gsub("index.html", "")
        sanitized_filename = sanitized_filename.gsub(".html", "")
        @filename_with_headers[sanitized_filename] = { :headers => headers }
      end

      sidebar = render
      files.each do | file |
        file.xpath("//*[@id=\"dg-sidebar\"]").each do | location |
          location.content = sidebar
        end
      end
      #raise "undead"
    end

    def render
      sidebar = "<div id=\"dg-sidebar\" class=\"sidebar\">"
      sidebar << "<nav class=\"sidebar-nav\">"
      sidebar << "<ul class=\"main-nav-ul\">"

      merged = merge(@hash_pre_render, @filename_with_headers)
      merged.each do |key, value|
        next if value[:title].nil?

        leaf = "<li class=\"nav-group\">"
        leaf << "<div class=\"nav-group-heading\"><i class=\"material-icons\">arrow_right</i><span>#{value[:title]}</span></div>"

        leaf << "<ul class=\"nav-ul\">"
        leaf << "<li class=\"nav-leaf\"><a href=\"#{value[:url]}\">#{value[:title]}</a></li>"

        if value[:headers].any?
          value[:headers].each do | header |
            leaf << "<li class=\"nav-leaf\"><a href=\"#{header[:url]}\">#{header[:title]}</a></li>"
          end
        end
        leaf << "</ul>"
        leaf << "</li>"
        sidebar << leaf
      end

      sidebar << "</ul>"
      sidebar << "</nav>"
      sidebar << "</div>"
      File.open("_site/sidebar.html", "w") { |f| f.write(sidebar) }
      return sidebar
    end

    private

    def merge(hash1, hash2)
      all_keys = hash1.keys | hash2.keys
      result_hash = {}

      all_keys.each do |key|
        hash_value = {}

        if hash1.has_key? key
          value = hash1[key]

          if not value.nil?
            hash_value = value
          end
        end

        if hash2.has_key? key
          value = hash2[key]

          if not value.nil?
            hash_value = hash_value.merge(value)
          end
        end

        result_hash[key] = hash_value
      end

      result_hash
    end
  end
end

sidebar = Jekyll::Sidebar.new

Jekyll::Hooks.register :site, :pre_render do |site, payload|
  site.pages.each do |page|
    sidebar.pre_render page
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  sidebar.post_write site
end
