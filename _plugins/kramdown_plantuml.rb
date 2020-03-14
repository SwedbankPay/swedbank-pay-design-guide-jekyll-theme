require 'shell'

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

    sh = Shell.new
    svg = (
      sh.echo(content) |
      # We need to capture the std and err output from the Java process
      # because even if conversion fails due to missing dot executable
      # or other problems, the exit code seems to be 0.
      sh.system("java -jar #{plant_uml_jar_file} -tsvg -pipe")
    ).to_s

    return svg
  end
end
