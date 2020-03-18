require 'open3'

class Kramdown::Converter::Html
  alias_method :super_convert_codeblock, :convert_codeblock

  def convert_codeblock(element, indent)
    if element.attr["class"] != "language-plantuml"
      return super_convert_codeblock(element, indent)
    end

    return convert_plantuml_to_svg(element.value)
  end

  def convert_plantuml_to_svg(content)
    # We should find a way to download the JAR file on `bundle install`
    plant_uml_jar_file = "./_plugins/plantuml.1.2020.2.jar"
    cmd = "java -jar #{plant_uml_jar_file} -tsvg -pipe"

    stdout, stderr, status = Open3.capture3(cmd, :stdin_data => content)

    unless stderr.empty?
      raise stderr
    end

    return stdout
  end
end
