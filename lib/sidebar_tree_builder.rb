# frozen_string_literal: false

require 'forwardable'
require_relative 'sidebar_page_collection'

module SwedbankPay
  # Arranges Sidebar pages into a tree
  class SidebarTreeBuilder
    include Enumerable
    extend Forwardable
    def_delegators :@pages, :each, :length, :empty?, :<<, :[], :count

    def initialize(pages)
      raise ArgumentError, 'Pages must be a Hash' unless pages.is_a? Hash

      @pages = tree(pages)
    end

    def to_s
      stringify
    end

    def inspect
      stringify(true)
    end

    private

    def stringify(inspect = false)
      s = "<#{self.class} ##{count}"

      if inspect
        s << ":\n"
        @pages.each do |page|
          s << "#{page}\n"
        end
      end

      s << '>'
      s
    end

    def tree(pages)
      tree = []
      children_of = {}
      page_number = 0

      sort_by_path_reversed(pages).each do |_, page|
        children_of[page.path] = [] if children_of[page.path].nil?
        page.children = children_of[page.path].sort

        if page.parent.nil?
          # Root pages are pushed directly into the root of the tree
          page.number = page_number
          tree.push(page)
          page_number += 1
        else
          children_of[page.parent] = [] if children_of[page.parent].nil?
          children_of[page.parent].push(page)
        end
      end

      SidebarPageCollection.new(nil, tree)
    end

    def sort_by_path_reversed(pages)
      pages.sort_by { |path, _| path }.reverse
    end
  end
end
