# frozen_string_literal: true

module Jekyll
  # Implements the 'Level' Liquid tag.
  class FieldTag < Liquid::Tag
    def initialize(tag_name, input, _)
      super

      (@field_name, @level) = parse_input(input)
    end

    def render(_context)
      return '' if @field_name.nil? || @field_name.empty?

      level_class = "field-level field-level-#{@level}"

      "<span class=\"#{level_class}\"><code class=\"language-json highlighter-rouge\">#{@field_name}</code></span>"
    end

    private

    def parse_input(input)
      return ['', 1] if input.nil? || input.empty? || input.strip.empty?
      return [input.strip, 1] unless input.include?(',')

      values = input.split(',')
      field_name = field_name(values)
      level = level(values)

      [field_name, level]
    end

    def field_name(values)
      values[0].strip
    end

    def level(values)
      return 1 if values.size == 1

      field_level = values[1].strip.to_i

      field_level.positive? ? field_level : 1
    rescue StandardError
      1
    end
  end
end

Liquid::Template.register_tag('f', Jekyll::FieldTag)
