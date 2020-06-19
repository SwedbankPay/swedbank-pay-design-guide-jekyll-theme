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
        doc.xpath("//h2 ").each do |header|
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
      Dir.glob("#{site.config["destination"]}/**/*.html") do |filename|
        file = File.open(filename) { |f| Nokogiri::HTML(f) }
        file.xpath("//*[@id=\"dx-sidebar-main-nav-ul\"]").each do | location |
          location.inner_html = sidebar
        end
        File.open(filename, 'w') { |f| f.write(file.to_xhtml(encoding: 'UTF-8')) }
      end
      File.open("_site/sidebar.html", 'w') { |f| f.write(sidebar) }
    end

    def generateSubgroup (key, value, has_subgroups)
      subgroup = ""
      if value[:headers].any?
        if has_subgroups
          subgroup << "<li class=\"nav-subgroup\">"
          subgroup << "<div class=\"nav-subgroup-heading\"><i class=\"material-icons\">arrow_right</i><a href=\"#{value[:url]}\">#{value[:title].split("–").last}</a></div>"
          subgroup << "<ul class=\"nav-ul\">"
          value[:headers].each do | header |
            subgroup << "<li class=\"nav-leaf\"><a href=\"#{header[:url]}\">#{header[:title]}</a></li>"
          end
          subgroup << "</ul>"
          subgroup << "</li>"
        else
          value[:headers].each do | header |
            subgroup << "<li class=\"nav-leaf\"><a href=\"#{header[:url]}\">#{header[:title]}</a></li>"
          end
        end
      else
        if has_subgroups
          subgroup << "<li class=\"nav-leaf nav-subgroup-leaf\"><a href=\"#{value[:url]}\">#{value[:title]}</a></li>"
        else
          subgroup << "<li class=\"nav-leaf\"><a href=\"#{value[:url]}\">#{value[:title]}</a></li>"
        end
      end

      return subgroup
    end

    def render
      sidebar = ""

      merged = merge(@hash_pre_render, @filename_with_headers)
      merged.select{|key, value| key.split("/").length <= 2}.sort_by{|key, value| value[:menu_order]}.each do |key, value|
        next if value[:title].nil?


        subgroups = merged.select{|subgroup_key, subgroup_value| subgroup_key.include? key and subgroup_key != key and key != "/"}
        
        child = "<li class=\"nav-group\">"
        child << "<div class=\"nav-group-heading\"><i class=\"material-icons\">arrow_right</i><span>#{value[:title].split("–").first}</span></div>"

        child << "<ul class=\"nav-ul\">"
        
        subgroup = generateSubgroup key, value, subgroups.length > 0

        child << subgroup

        if subgroups.any?
          subgroups.each do |subgroup_key, subgroup_value|
            subgroup = generateSubgroup subgroup_key, subgroup_value, true
            child << subgroup
          end
        end

        child << "</ul>"
        child << "</li>"
        sidebar << child
      end

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
