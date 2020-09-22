# frozen_string_literal: false

require 'forwardable'

module SwedbankPay
  # Arranges Sidebar pages into a tree
  class SidebarTreeBuilder
    include Enumerable
    extend Forwardable
    def_delegators :@pages, :each, :length, :<<, :[]

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

    def count
      count_pages(@pages)
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

    def count_pages(pages)
      return 0 if pages.nil? || pages.empty?

      count = pages.length

      pages.each do |page|
        count += count_pages(page.children)
      end

      count
    end

    def tree(pages)
      tree = []
      children_of = {}

      sort(pages).each do |_, page|
        children_of[page.path] = [] if children_of[page.path].nil?
        page.children = children_of[page.path].sort

        if page.parent.nil?
          tree.push(page)
        else
          children_of[page.parent] = [] if children_of[page.parent].nil?
          children_of[page.parent].push(page)
        end
      end

      tree
    end

    def sort(pages)
      pages.sort_by { |path, _| path }.reverse
    end

    def order(pages)
      pages.sort do |a, b|
        return 1 if a.nil? || a.title.nil?
        return -1 if b.nil? || b.title.nil?

        a.title.to_s <=> b.title.to_s
      end.sort_by { |page| page.order }
    end
  end
end
