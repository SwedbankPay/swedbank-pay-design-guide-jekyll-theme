# frozen_string_literal: true

require_relative 'sanitized_filename'
require_relative 'sidebar_page_title'

module SwedbankPay
  # Represents a page in the Sidebar
  class SidebarPath
    attr_reader :parent, :level, :name

    def initialize(path)
      @segments = segment(path)
      @path = normalized(path)
      @name = construct_name
      @parent = find_parent
    end

    def to_s
      @path
    end

    def inspect
      to_s
    end

    private

    def segment(path)
      segments = path.sanitized.split('/').reject(&:empty?)
      @level = segments.length.zero? ? 0 : segments.length - 1
      segments
    end

    def normalized(path)
      return '/' if @segments.empty?

      joined = "/#{@segments.join('/')}"

      # Directory paths should end with '/'.
      directory?(path) ? "#{joined}/" : joined
    end

    def directory?(path)
      path.end_with?('/') || path.end_with?('/index.html')
    end

    def construct_name
      return '/' if @path == '/'

      @segments.last
    end

    def find_parent
      # If there's no or only one path segment, this is a root page
      return nil if @segments.empty? || (@segments.length == 1)

      # Return the path minus the last segment as the parent path
      last = @path.sub(%r{(/#{@segments.last}/?)$}, '')
      "#{last}/"
    end
  end
end
