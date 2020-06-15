require "jekyll"
require "nokogiri"
require 'json'

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
      @hash_pre_render[page["url"]] = {
        :title => page["title"],
        :url => page["url"],
        :name => page["name"],
        "menu-order" => menu_order
      }
    end

    def post_write(site)
      Dir.glob("#{site.config["destination"]}/**/*.html") do | filename |
        doc = File.open(filename) { |f| Nokogiri::HTML(f) }
        title = doc.title
        url = ""
        doc.xpath("/html/head/meta").each do | meta |
          if meta.attr("property").eql? "og:url"
            url = meta.attr("value") 
          end
        end

        headers = {}
        doc.xpath("//h2 | //h2 | //h3 | //h4 | //h5 | //h6").each do | header |
          if not header["id"]
            next
          end
          child = header.last_element_child 
          headers[header["id"]] = {
            :title => header.content.strip,
            :url => "#{url}#{child["href"]}"
          }
        end
        @filename_with_headers[filename.match(/(?m)(?<=\b_site).*$/)] = headers
      end

      render
    end

    def render
      File.open("filename_with_headers.log", "w") { |f| f.write(JSON.pretty_generate @filename_with_headers)}
      File.open("hash_pre_render.log", "w") { |f| f.write(JSON.pretty_generate @hash_pre_render)}
      merged = @hash_pre_render.merge(@filename_with_headers) {|key, a_val, b_val| a_val.merge b_val }
      File.open("merged.log", "w") { |f| f.write(JSON.pretty_generate merged)}

      sidebar = "<div id=\"dg-sidebar\" class=\"sidebar\">"
      sidebar << "<nav class=\"sidebar-nav\">"
      sidebar << "<ul class=\"main-nav-ul\">"

      merged.each do | row, value |
        leaf = "<li class=\"nav-group\">"
        leaf << "<div class=\"nav-group-heading\"><i class=\"material-icons\">arrow_right</i><span>#{value[:title]}</span></div>"
        #puts row
        #puts value
        leaf << "</li>"
        sidebar << leaf
      end

      sidebar << "</ul>"
      sidebar << "</nav>"
      sidebar << "</div>"
      puts sidebar
      raise "army of hell"
    end
  end
end

sidebar = Jekyll::Sidebar.new

Jekyll::Hooks.register :site, :pre_render do | site, payload |
  site.pages.each do | page |
    sidebar.pre_render page
  end
  
end

Jekyll::Hooks.register :site, :post_write do | site |
  sidebar.post_write site
end
