# frozen_string_literal: true

require 'liquid'

# Module SwedbankPay
module SwedbankPay
  # Adds a 'regex_capture' filter to Liquid. Performs a regular expression match
  # on the provided string and returns the capture as an array. Example usage:
  # {{ html | regex_capture: 'id="([^"]+)"' | first }}
  module RegexCaptureFilter
    def regex_capture(str, regex)
      match = /#{regex}/.match(str)
      match ? match.captures : []
    end
  end
end

Liquid::Template.register_filter(SwedbankPay::RegexCaptureFilter)
