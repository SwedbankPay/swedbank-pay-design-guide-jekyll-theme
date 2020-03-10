require 'nokogiri'

plant_uml_jar_file = "./.github/scripts/plantuml.1.2020.2.jar"
diagram_directory = "./_site/assets/diagrams"

html_files = Dir[ './_site/**/*.html' ].select{ |f| File.file? f }

Dir.mkdir(diagram_directory) unless File.exists?(diagram_directory)

html_files.each_with_index do |file, file_index|
  dirname = File.dirname(file)
  parsed_html = Nokogiri::HTML.parse(File.open(file, "r"))
  parsed_html.css(".language-plantUML").each do | tag |
    uml_file_name = "#{diagram_directory}/#{File.basename(file, ".*")}_#{file_index}"
    uml_file = File.open("#{uml_file_name}.puml", "w+"){ |f| f.write(tag.text)}
    # exec "echo #{puts tag.text}"
    #exec "#{uml_file_name}.puml | java -jar #{plant_uml_jar_file} -pipe > #{uml_file_name}.png"
    # `echo #{tag.text} | java -jar #{plant_uml_jar_file} -pipe > #{uml_file_name}.png`
    #`echo #{puts tag.text} | java -jar #{plant_uml_jar_file} -pipe > #{uml_file_name}.png`
    system("java -jar #{plant_uml_jar_file} -tpng #{uml_file_name}.puml") or raise "PlantUml error"
    image_node = parsed_html.create_element "img"
    image_node['src'] = "#{uml_file_name}.png"
    tag.replace(image_node)
    # puts image_node
    # puts tag
  end
  File.write(file, parsed_html)
end
