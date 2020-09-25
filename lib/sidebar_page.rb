# frozen_string_literal: false

require 'jekyll'
require_relative 'sidebar_path'
require_relative 'sidebar_page_title'

module SwedbankPay
  # Represents a page in the Sidebar
  class SidebarPage
    attr_reader :path, :title, :parent, :level
    attr_accessor :headers, :children, :doc

    def initialize(page)
      raise ArgumentError, 'Page must be a Jekyll::Page' unless page.is_a? Jekyll::Page

      sidebar_path = SidebarPath.new(page['url'])
      @path = sidebar_path.to_s
      @parent = sidebar_path.parent
      @level = sidebar_path.level
      @name = sidebar_path.name
      @hide_from_sidebar = page['hide_from_sidebar'].nil? ? false : page['hide_from_sidebar']
      @title = construct_title(page)
      @menu_order = page['menu_order'].nil? ? 0 : page['menu_order']
    end

    def ignore?
      return true if @title.nil?
      return true if @hide_from_sidebar

      false
    end

    def to_s
      c = ''

      unless @children.nil? || @children.empty?
        @children.each do |child|
          indent = '-' * @level
          c << "\n#{indent}#{child}"
        end
      end

      "- #{@name}#{c}"
    end

    def inspect
      to_s
    end

    private

    def construct_title(page)
      title = page[:title]
      return nil if title.nil?

      SidebarPageTitle.new(title)
    end
  end
end
