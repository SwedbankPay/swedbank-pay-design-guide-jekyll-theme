require "jekyll"
require "nokogiri"
require 'json'

Jekyll::Hooks.register :site, :post_write do | site |
  filename_with_headers = {}
  Dir.glob("#{site.config["destination"]}/**/*.html") do | filename |
#    puts filename
    doc = File.open(filename) { |f| Nokogiri::HTML(f) }
    title = doc.title
    url = ""
    doc.xpath("/html/head/meta").each do | meta |
      url = meta.attr("value") if meta.attr("property").eql? "og:url"
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
