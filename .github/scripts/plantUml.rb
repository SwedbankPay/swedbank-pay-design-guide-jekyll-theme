require 'nokogiri'
require 'tempfile'

plant_uml_jar_file = "./.github/scripts/plantuml.1.2020.2.jar"
plant_uml_file_name = "plant_uml.txt"

html_files = Dir[ './_site/**/*.html' ].select{ |f| File.file? f } 

for file in html_files do
  if file != './_site/index.html'
    next
  end
  parsed_html = Nokogiri::HTML.parse(File.open(file, "r"))
  plant_uml_tags = parsed_html.css(".language-plantUML")
  plant_uml_tags.each do |tag|
    # puts tag.text
    uml_file = File.open(plant_uml_file_name, "w") { |f| f.write(tag.text)}
    puts uml_file
    exec "java -jar #{plant_uml_jar_file} #{plant_uml_file_name}"
    puts uml_file
  end
end