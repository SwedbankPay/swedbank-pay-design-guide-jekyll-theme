require "jekyll"
require "nokogiri"
require 'json'

Jekyll::Hooks.register :site, :post_write do | site |
  File.open("site.log", 'w') { |file| file.write(site.inspect) }

  Dir.glob("#{site.config["destination"]}/**/*.html") do | filename |
    puts filename
    doc = File.open(filename) { |f| Nokogiri::HTML(f) }
    title = doc.title
    url = ""
    doc.xpath("/html/head/meta").each do | meta |
      url = meta.attr("value") if meta.attr("property").eql? "og:url"
    end
    
    headers = doc.css("h1, h2, h3, h4, h5, h6")
    headers.each do | header |
      #puts header
    end
  end
  raise "hel"
end
