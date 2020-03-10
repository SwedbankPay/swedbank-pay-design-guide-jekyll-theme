require 'nokogiri'
require 'dimensions'

plant_uml_jar_file = "./.github/scripts/plantuml.1.2020.2.jar"
diagram_directory = "assets/diagrams"

html_files = Dir[ './_site/**/*.html' ].select{ |f| File.file? f }

Dir.mkdir("./_site/#{diagram_directory}") unless File.exists?(diagram_directory)

html_files.each_with_index do |file, file_index|
  dirname = File.dirname(file)
  parsed_html = Nokogiri::HTML.parse(File.open(file, "r"))
  parsed_html.css(".language-plantUML").each_with_index do | tag, tag_index |
    uml_file_base_name = "#{File.basename(file, ".*")}_#{file_index}_#{tag_index}"
    uml_file_name = "./_site/#{diagram_directory}/#{uml_file_base_name}"
    uml_file = File.open("#{uml_file_name}.puml", "w+"){ |f| f.write(tag.text)}
    system("java -jar #{plant_uml_jar_file} -tsvg #{uml_file_name}.puml") or raise "PlantUml error"

    tag.parent.replace(File.read("#{uml_file_name}.svg"))
  end
  File.write(file, parsed_html)
end
