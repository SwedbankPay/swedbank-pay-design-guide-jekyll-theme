# frozen_string_literal: true

require_relative 'sanitized'
require_relative 'sidebar_page_title'

module SwedbankPay
  # Represents a page in the Sidebar
  class SidebarPath
    attr_reader :parent, :level, :name

    def initialize(path)
      @segments = segment(path)
      @path = normalized
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
      @level = segments.length == 0 ? 0 : segments.length - 1
      return segments
    end

    def normalized
      return '/' if @segments.empty?

      joined = @segments.join('/')
      "/#{joined}"
    end

    def construct_name
      return '/' if @path == '/'

      @segments.last
    end

    def find_parent
      # If there's no or only one path segment, this is a root page
      return nil if @segments.empty? || (@segments.length == 1)

      # Return the path minus the last segment as the parent path
      @path.chomp("/#{@segments.last}")
    end
  end
end
