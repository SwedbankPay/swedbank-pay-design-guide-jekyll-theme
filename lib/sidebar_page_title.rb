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
  end
end
