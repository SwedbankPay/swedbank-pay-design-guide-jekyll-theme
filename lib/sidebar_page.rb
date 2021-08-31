# frozen_string_literal: true

require 'jekyll'
require 'nokogiri'
require_relative 'sidebar_logger'
require_relative 'sidebar_path'
require_relative 'sidebar_page_title'
require_relative 'sidebar_page_collection'
require_relative 'sidebar_text_builder'

module SwedbankPay
  # Represents a jekyll_page in the Sidebar
  class SidebarPage
    FIXNUM_MAX = ((2**((0.size * 8) - 2)) - 1)

    attr_reader :path, :title, :level, :order, :children, :name, :filename, :doc
    attr_accessor :headers, :sidebar_container, :number, :parent

    def initialize(jekyll_page)
      raise ArgumentError, 'jekyll_page cannot be nil' if jekyll_page.nil?
      raise ArgumentError, 'jekyll_page must be a Jekyll::Page' unless jekyll_page.is_a? Jekyll::Page

      @filename = jekyll_page.destination('')
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
      @card_overview = jekyll_page['card_overview'].nil? ? false : jekyll_page['card_overview']
      @anchor_headings = jekyll_page['anchor_headings'].nil? ? true : jekyll_page['anchor_headings']
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
      if @jekyll_page.data['layout'] == 'search'
        # Never show the search result page in the menu.
        return true
      end

      # The current page should be hidden for the other page unless the
      # other page is also hidden.
      hidden = hidden?

      if other_page.nil? || !other_page.is_a?(SidebarPage)
        SidebarLogger.debug("Other page '#{other_page}' is nil or not a SidebarPage")
        return hidden
      end

      # If the other page is hidden, the current page should not be hidden
      # from it.
      return false if other_page.hidden? && in_same_section_as?(other_page)

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
        SidebarLogger.debug("No title for #{@name}")
        return
      end

      SidebarLogger.debug("<#{@path}>.lead_title('#{@title.lead}').main_title('#{@title.main}')")

      @jekyll_page.data['lead_title'] = @title.lead
      @jekyll_page.data['main_title'] = @title.main
      @jekyll_page.data['children'] = @children
      @jekyll_page.data['absolute_path'] = @path
    end

    def save
      SidebarLogger.debug("   Writing Sidebar: #{filename}")

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
      return @number.to_s unless @parent.respond_to? :coordinate

      "#{@parent.coordinate}.#{@number}"
    end

    def load
      @doc = File.open(@filename) { |f| Nokogiri::HTML(f) }
      @doc
    end

    def to_liquid
      @jekyll_page.to_liquid
    end

    def card_overview?
      @card_overview
    end

    def anchor_headings?
      @anchor_headings
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
        SidebarLogger.warn('Nil current_page')
        return ''
      end

      return current if current.is_a? String
      return current.path if current.respond_to?(:path)

      SidebarLogger.warn("#{current.class} ('#{current}') does not respond to :path.")

      ''
    end

    def in_same_section_as?(other_page)
      # If this or the other page is the root index page, just ignore the
      # hidden state completely
      return false if other_page.path == '/' || @path == '/'

      other_page.path.start_with?(@path) || @path.start_with?(other_page.path)
    end
  end
end
