require "jekyll"
require "nokogiri"
require "securerandom"

module Jekyll
  class Sidebar
    attr_accessor :uuid
    def initialize
      @uuid = SecureRandom.uuid 
    end

    def post_write(site)
      filename_with_headers = {}
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
            :content => header.content.strip,
            :url => "#{url}#{child["href"]}"
          }
        end
        filename_with_headers[filename] = headers
      end
      puts filename_with_headers
      raise "hel"
    end
  end
end

sidebar = Jekyll::Sidebar.new

Jekyll::Hooks.register :site, :post_render do |post|
  puts sidebar.uuid
end

Jekyll::Hooks.register :site, :post_write do | site |
  puts sidebar.uuid
  sidebar.post_write site
end
