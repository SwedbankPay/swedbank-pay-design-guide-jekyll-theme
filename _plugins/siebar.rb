require "jekyll"
require "nokogiri"

module Jekyll
  class Sidebar
    def initialize      
    end

    # Payload is a Jekyll::Drops::UnifiedPayloadDrop
    def generate(payload)
      #File.open("payload.txt", 'w') { |file| file.write(payload.page) }
    end
  end
end


Jekyll::Hooks.register :site, :post_render do |site, payload|
  # code to call after Jekyll renders a post
  menu = {}
  site.pages.each.with_index do | value, index |
    
    doc = Nokogiri::HTML.parse(value.content)
    doc_xpath = doc.xpath("//h[1-6]")
    File.open("page-#{index}.txt", 'w') { |file| file.write(doc) }
    
  end
  sidebar = Jekyll::Sidebar.new
  generated = sidebar.generate payload
  #File.open("site.txt", 'w') { |file| file.write(site.pages.methods - Object.methods) }

  raise "hell"
end