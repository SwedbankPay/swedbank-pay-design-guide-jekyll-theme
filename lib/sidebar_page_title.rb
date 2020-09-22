# frozen_string_literal: true

module SwedbankPay
  # Represents the title of a SidebarPage
  class SidebarPageTitle
    attr_reader :section
    attr_reader :item

    def initialize(title)
      @title = title
      parts = title.split('–')
      @section = parts.first.strip
      @item = parts.last.strip
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
  end
end
