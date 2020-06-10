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
  site.pages.each.with_index do | page, index |
    unless page.html?
      next
    end

    sidebar_content = {}
    sidebar_content["title"] = page.data["title"]
    sidebar_content["file_name"] = page.name
    sidebar_content["url"] = page.url
    
    doc = Nokogiri::HTML.parse(page.content)
    doc_xpath = doc.css("h1, h2, h3, h4, h5, h6")
    File.open("page-#{index}.txt", 'w') { |file| file.write("#{doc_xpath}") }
    
  end
  sidebar = Jekyll::Sidebar.new
  generated = sidebar.generate payload
  #File.open("site.txt", 'w') { |file| file.write(site.pages.methods - Object.methods) }

  raise "hell"
end