# frozen_string_literal: true

require 'jekyll'
require_relative 'sidebar_page'

module SwedbankPay
  # Represents the title of a SidebarPage
  class SidebarPageTitle
    attr_reader :main, :section

    def self.parse(jekyll_page, sidebar_page)
      raise ArgumentError, 'jekyll_page cannot be nil' if jekyll_page.nil?
      raise ArgumentError, 'jekyll_page must be a Jekyll::Page' unless jekyll_page.is_a? Jekyll::Page
      raise ArgumentError, 'sidebar_page cannot be nil' if sidebar_page.nil?
      raise ArgumentError, 'sidebar_page must be a SidebarPage' unless sidebar_page.is_a? SidebarPage

      title = jekyll_page['title']
      section = jekyll_page['section']
      return nil if title.nil?

      SidebarPageTitle.new(title, section, sidebar_page)
    end

    def lead
      section = find_section(@page)
      return section unless section.nil?

      @lead
    end

    def to_s
      @title
    end

    def inspect
      @title
    end

    def <=>(other)
      return -1 if other.nil?

      @title <=> other.to_s
    end

    private

    def initialize(title, section, page)
      raise ArgumentError, 'title cannot be nil' if title.nil?
      raise ArgumentError, 'title must be a String' unless title.is_a? String
      raise ArgumentError, 'page cannot be nil' if page.nil?
      raise ArgumentError, 'page must be a SidebarPage' unless page.is_a? SidebarPage

      @page = page
      @title = title
      parts = title.split('–')
      @section = section
      @lead = parts.first.strip
      @main = parts.last.strip
    end

    def find_section(page)
      # Return the 'section' front matter if it can be found on the current page.
      return page.title.section unless page.nil? || page.title.nil? || page.title.section.nil? || page.title.section.empty?

      # Recurse upwards to the root (until there is no parent).
      return find_section(page.parent) unless page.nil? || page.parent.nil?

      nil
    end
  end
end
