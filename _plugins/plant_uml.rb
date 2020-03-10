#Jekyll::Hooks.register([:pages, :posts], :pre_render) do |doc, _|

  # code goes here
#  puts doc

#end

require 'fileutils'

Jekyll::Hooks.register([:pages, :posts], :post_render) do |post|
  #puts post
  #puts post.inspect
  #puts post.methods
  #puts post.name
  
  plant_uml_jar_file = "./.github/scripts/plantuml.1.2020.2.jar"
  diagram_directory = "assets/diagrams"

  FileUtils.mkdir_p diagram_directory

  parsed_html = Nokogiri::HTML.parse(post.content)

  parsed_html.css(".language-plantUML").each_with_index do | tag, tag_index |
    uml_file_base_name = "#{post.name}_#{tag_index}"
    uml_file_name = "./_site/#{diagram_directory}/#{uml_file_base_name}"
    uml_file = File.open("#{uml_file_name}.puml", "w+"){ |f| f.write(tag.text)}
    system("java -jar #{plant_uml_jar_file} -tsvg #{uml_file_name}.puml") or raise "PlantUml error"

    tag.parent.replace(File.read("#{uml_file_name}.svg"))
  end
  post.content = parsed_html
end