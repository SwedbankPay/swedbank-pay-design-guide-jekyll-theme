module SwedbankPay
  class IconTag < Liquid::Tag
    safe true

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "<i class=\"material-icons\">#{@text}</i>"
    end
  end
end

Liquid::Template.register_tag('icon', SwedbankPay::IconTag)
