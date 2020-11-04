# frozen_string_literal: false

require 'jekyll'
require 'forwardable'
require_relative 'sidebar_page_collection'

module SwedbankPay
  # Arranges Sidebar pages into a tree
  class SidebarTreeBuilder
    include Enumerable
    extend Forwardable
    def_delegators :@tree, :each, :length, :empty?, :<<, :[], :count

    def initialize(pages)
      raise ArgumentError, 'pages cannot be nil' if pages.nil?
      raise ArgumentError, 'pages must be a Hash' unless pages.is_a? Hash

      @tree = tree(pages)
      enrich_jekyll_pages(@tree)
    end

    def to_s
      stringify
    end

    def inspect
      stringify(inspection: true)
    end

    private

    def stringify(inspection: false)
      output = "<#{self.class} ##{count}"

      if inspection
        output << ":\n"
        @tree.each do |page|
          output << "#{page}\n"
        end
      end

      output << '>'
      output
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

      # Sort the root pages
      tree.sort!

      SidebarPageCollection.new(nil, tree)
    end

    def sort_by_path_reversed(pages)
      pages.sort_by { |path, _| path }.reverse
    end

    def enrich_jekyll_pages(pages)
      return if pages.empty?

      pages.each do |page|
        page.enrich_jekyll

        enrich_jekyll_pages(page.children)
      end
    end
  end
end
