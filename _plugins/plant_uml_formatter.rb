require 'rouge'

module Rouge
  module Formatters
    class PlantUmlFormatter < HTML
      tag 'platnuml'

      def stream(tokens, &block)
        if tokens.inspect.include? 'Rouge::Lexers::PlantUml'
          puts "PlantUML"
        end
        # 1. We need to figure out which lexer is used for the given tokens.
        #    This is visible if we do `puts tokens.inspect`, but I have no
        #    idea how to write an `if` statement for it.
        # 2. If the lexer is Rouge::Lexers::PlantUml we have to extract all the
        #    contrent and pass it to the plantuml command line and then return
        #    (yield) the converted SVG.
        # 3. We need to be able to invoke the default formatter when the lexer
        #    is not as Rouge::Lexers::PlantUml. HTML::stream does not seem to
        #    do what we want for some reason.
        yield %(<div class="highlight"><pre class="highlight"><code>)
        super
        yield "</code></pre></div>"
      end

    def convert(content)
        puts content
        plant_uml_jar_file = "./_plugins/plantuml.1.2020.2.jar"
        diagram_directory = "_site/assets/diagrams"

        FileUtils.mkdir_p(diagram_directory) unless File.exists?(diagram_directory)

        parsed_html = Nokogiri::HTML.parse(post.output)

        parsed_html.css(".language-plantUML, .language-plantuml, .language-plantUml").each_with_index do | tag, tag_index |
            uml_file_base_name = "#{post.name}_#{tag_index}"
            uml_file_name = "#{diagram_directory}/#{uml_file_base_name}"
            uml_file = File.open("#{uml_file_name}.puml", "w+"){ |f| f.write(tag.text)}

            system("java -jar #{plant_uml_jar_file} -tsvg #{uml_file_name}.puml") or raise "PlantUml error"

            tag.parent.replace(File.read("./#{uml_file_name}.svg"))
        end
        post.output = parsed_html.to_html

      end
    end
  end

  # Copied and modified from:
  # https://opensource-dev.ieee.org/j.gay/gitlab-ce/blob/c50cded96e5f6f0eaadf9e49ac98f722f09b8fa8/lib/rouge/lexers/plantuml.rb
  module Lexers
    class PlantUml < PlainText
      title "A passthrough lexer used for PlantUML input"
      tag 'plantuml'

      def initialize(*)
        super
        @plantuml = true
      end
    end
  end
end
