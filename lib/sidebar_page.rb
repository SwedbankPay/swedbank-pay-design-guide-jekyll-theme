# frozen_string_literal: false

require 'jekyll'
require_relative 'sidebar_path'
require_relative 'sidebar_page_title'
require_relative 'sidebar_page_collection'
require_relative 'sidebar_text_builder'

module SwedbankPay
  # Represents a jekyll_page in the Sidebar
  class SidebarPage
    FIXNUM_MAX = (2**(0.size * 8 - 2) - 1)

    attr_reader :path, :title, :level, :order, :children, :name
    attr_accessor :headers, :filename, :doc, :sidebar_container, :number, :parent

    def initialize(jekyll_page)
      raise ArgumentError, 'jekyll_page cannot be nil' if jekyll_page.nil?
      raise ArgumentError, 'jekyll_page must be a Jekyll::Page' unless jekyll_page.is_a? Jekyll::Page

      @jekyll_page = jekyll_page
      sidebar_path = SidebarPath.new(jekyll_page['url'])
      @path = sidebar_path.to_s
      @parent = sidebar_path.parent
      @level = sidebar_path.level
      @name = sidebar_path.name
      @hide_from_sidebar = jekyll_page['hide_from_sidebar'].nil? ? false : jekyll_page['hide_from_sidebar']
      @title = SidebarPageTitle.parse(jekyll_page, self)
      @order = menu_order(jekyll_page)
      @children = SidebarPageCollection.new(self)
    end

    def active?(current, is_leaf: false)
      current_path = find_path(current)

      return true if @path == current_path

      # If we're on a leaf node item, such as when rendering the first header
      # item of a sub-group, its children's active state must be disregarded.
      unless is_leaf
        @children.each do |child|
          return true if child.active?(current_path, is_leaf: is_leaf)
        end
      end

      false
    end

    def hidden?
      return true if @title.nil?
      return true if @hide_from_sidebar

      false
    end

    def hidden_for?(other_page)
      # The current page should be hidden for the other page unless the
      # other page is also hidden.
      #
      # TODO: Make it so that hiddden pages within a section are visible
      #       for each other, but not for other sections, regardless if
      #       they are hidden or not.
      hidden = hidden?

      if other_page.nil? || !other_page.is_a?(SidebarPage)
        Jekyll.logger.debug("           Sidebar: Other page '#{other_page}' is nil or not a SidebarPage")
        return hidden
      end

      return false if other_page.hidden?

      hidden
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

      @order <=> other.order
    end

    def enrich_jekyll
      if @title.nil?
        Jekyll.logger.debug("           Sidebar: No title for #{@name}")
        return
      end

      Jekyll.logger.debug("           Sidebar: #{@name}.lead_title '#{@title.lead}'")
      Jekyll.logger.debug("           Sidebar: #{@name}.main_title '#{@title.main}'")

      @jekyll_page.data['lead_title'] = @title.lead
      @jekyll_page.data['main_title'] = @title.main
    end

    def save
      Jekyll.logger.debug("   Writing Sidebar: #{filename}")

      File.open(@filename, 'w') do |file|
        html = @doc.to_html(encoding: 'UTF-8')
        file.write(html)
      end
    end

    def children?
      !children.nil? && children.any?
    end

    def headers?
      !headers.nil? && headers.any?
    end

    def coordinate
      return @number.to_s if @parent.nil?

      "#{@parent.coordinate}.#{@number}"
    end

    private

    def menu_order(jekyll_page)
      order = jekyll_page['menu_order']
      return FIXNUM_MAX if order.nil? || order.to_s.empty?

      order.to_i
    end

    def eq?(path)
      @path == path
    end

    def child_of?(path)
      @path.split('/').length > @level && path.start_with?(@path)
    end

    def find_path(current)
      if current.nil?
        Jekyll.logger.warn('           Sidebar: Nil current_page')
        return ''
      end

      return current if current.is_a? String
      return current.path if current.respond_to?(:path)

      Jekyll.logger.warn("           Sidebar: #{current.class} ('#{current}') does not respond to :path.")

      ''
    end
  end
end
