# frozen_string_literal: false

require 'jekyll'
require_relative 'sidebar_path'
require_relative 'sidebar_page_title'
require_relative 'sidebar_page_collection'
require_relative 'sidebar_text_builder'

module SwedbankPay
  # Represents a page in the Sidebar
  class SidebarPage
    FIXNUM_MAX = (2**(0.size * 8 - 2) - 1)

    attr_reader :path, :title, :parent, :level, :order, :children, :name
    attr_accessor :headers, :filename, :doc, :sidebar_container, :number, :parent

    def initialize(page)
      raise ArgumentError, 'Page must be a Jekyll::Page' unless page.is_a? Jekyll::Page

      sidebar_path = SidebarPath.new(page['url'])
      @path = sidebar_path.to_s
      @parent = sidebar_path.parent
      @level = sidebar_path.level
      @name = sidebar_path.name
      @hide_from_sidebar = page['hide_from_sidebar'].nil? ? false : page['hide_from_sidebar']
      @title = page_title(page)
      @order = menu_order(page)
      @children = SidebarPageCollection.new(self)
    end

    def active?(current_page)
      current_path = current_page.path

      if @path == '/' || current_path == '/'
        return true if @path == '/' && current_path == '/'

        return false
      end

      if @level > 0
        return (@path == current_path) || (@path.split('/').length > @level && current_path.start_with?(@path))
      end

      return @path.start_with?(current_path)
    end

    def ignore?
      return true if @title.nil?
      return true if @hide_from_sidebar

      false
    end

    def children=(children)
      @children = SidebarPageCollection.new(self, children)
    end

    def to_s
      SidebarTextBuilder.new(self).to_s
    end

    def inspect
      to_s
    end

    def <=>(other)
      return -1 if other.nil?

      if @order == FIXNUM_MAX && other.order == FIXNUM_MAX
        return 0 if @title.nil? && other.title.nil?
        return -1 if other.title.nil?
        return 1 if title.nil?

        return @title <=> other.title
      end

      return @order <=> other.order
    end

    def save
      Jekyll.logger.debug("   Writing Sidebar: #{filename}")

      File.open(@filename, 'w') do |file|
        html = @doc.to_html(encoding: 'UTF-8')
        file.write(html)
      end
    end

    def has_headers?
      !headers.nil? && headers.any?
    end

    private

    def page_title(page)
      title = page['title']
      return nil if title.nil?

      SidebarPageTitle.new(title)
    end

    def menu_order(page)
      order = page['menu_order']
      return FIXNUM_MAX if order.nil? || order.to_s.empty?

      order.to_i
    end
  end
end