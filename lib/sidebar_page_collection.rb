# frozen_string_literal: false

require 'forwardable'

module SwedbankPay
  # Arranges Sidebar pages into a tree
  class SidebarPageCollection
    include Enumerable
    extend Forwardable
    def_delegators :@pages, :each, :length, :empty?, :[]

    def initialize(parent, pages = [])
      raise ArgumentError, 'Pages must be an array' unless pages.is_a? Array

      @pages = []

      pages.each_with_index do |page, index|
        page.number = index
        page.parent = parent
        page.freeze
        @pages.push(page)
      end
    end

    def count
      return 0 if @pages.empty?

      count = @pages.length

      @pages.each do |page|
        count += page.children.count
      end

      count
    end
  end
end
