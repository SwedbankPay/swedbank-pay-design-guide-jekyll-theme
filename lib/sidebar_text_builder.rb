# frozen_string_literal: false

require_relative 'sidebar_page'

module SwedbankPay
  # Builds a plain text representation of a Sidebar, suitable for a terminal.
  class SidebarTextBuilder
    def initialize(page)
      raise ArgumentError, 'Page must be a SidebarPage' unless page.is_a? SidebarPage

      @page = page
    end

    def to_s
      name = @page.name == '/' ? '/' : "/#{@page.name}"
      title = @page.title.nil? ? '?' : @page.title.item
      s = "#{indent} #{name}: #{title} (#{@page.level}, #{@page.number})\n"

      unless @page.children.empty?
          @page.children.each do |child|
          s << child.to_s
          end
      end

      # Only strip extraneous whitespace at the root page
      @page.level == 0 ? s.strip : s
    end

    private

    def indent
      # Return a special character for the first root page
      return '┍╾' if @page.number == 0 && @page.parent.nil?

      increment = @page.level > 1 ? @page.level + 1 : @page.level

      '┝╾' +  ('─' * increment)

      # TODO: Add logic to find the very last page regardless of level and have indent it with '┕╾─'
    end
  end
end
