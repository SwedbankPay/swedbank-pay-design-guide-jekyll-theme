require 'nokogiri'

html_files = Dir[ './_site/**/*.html' ].select{ |f| File.file? f } 

for file in html_files do
  if file != './_site/index.html'
    next
  end
  parsed_html = Nokogiri::HTML.parse(File.open(file, "r"))
  plant_uml_tags = parsed_html.css(".language-plantUML")
  plant_uml_tags.each do |tag|
    puts tag.text
  end
end