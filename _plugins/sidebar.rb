require "jekyll"
require "nokogiri"

module Jekyll
  class Sidebar
    def post_write (site)
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
      #raise "hel"
    end
  end
end

Jekyll::Hooks.register :site, :post_write do | site |
  sidebar = Jekyll::Sidebar
  puts sidebar.inspect
  sidebar.post_write site
end
