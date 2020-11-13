# frozen_string_literal: true

require 'liquid'

module Jekyll
  module RegexCapture
    def regex_capture(str, regex)
      match = /#{regex}/.match(str)
      return match ? match.captures : []
    end
  end
end

Liquid::Template.register_filter(Jekyll::RegexCapture)
