# frozen_string_literal: true

# Module SwedbankPay
module SwedbankPay
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

      field_level = values[1].strip

      # Check if the level is a valid number, otherwise default to 1
      return 1 unless /\A[-+]?\d*\.?\d+\z/.match(field_level)

      field_level = field_level.to_i

      field_level >= 0 ? field_level : 1
    rescue StandardError
      1
    end
  end
end

Liquid::Template.register_tag('f', SwedbankPay::FieldTag)
