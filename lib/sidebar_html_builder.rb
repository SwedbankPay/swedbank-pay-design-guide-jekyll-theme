# frozen_string_literal: false

require_relative 'sidebar_page'

module SwedbankPay
  # The builder of HTML for the Sidebar
  class SidebarHTMLBuilder
    def initialize(tree)
      @tree = tree
    end

    def build(current_page)
      build_markup(@tree, current_page)
    end

    private

    def build_markup(pages, current_page)
      return '' if pages.empty?

      markup = ''

      pages.each do |page|
        next if page.ignore?

        markup << item_markup(page, current_page)
      end

      markup
    end

    def item_markup(page, current_page)
      title = page.level == 0 ? page.title.section : page.title.item
      item_class = item_class(page, current_page)
      group_class = group_class(page, current_page)
      sub_items_markup = sub_items_markup(page, current_page)

      "<li class=\"#{item_class}\">
        <div class=\"#{group_class}\">
          <i class=\"material-icons\">arrow_right</i>
          <span>#{title}</span>
        </div>
        #{sub_items_markup}
      </li>"
    end

    def item_class(page, current_page)
      cls = page.level == 0 ? 'nav-group' : 'nav-subgroup'
      cls += ' active' if page.active?(current_page)
      cls
    end

    def group_class(page, current_page)
      group = page.level == 0 ? 'group' : 'subgroup'
      "nav-#{group}-heading"
    end

    def sub_items_markup(page, current_page)
      headers_markup = headers_markup(page)
      child_markup = build_markup(page.children, current_page)

      return '' if headers_markup.empty? && child_markup.empty?

      "<ul class=\"nav-ul\">
        #{headers_markup}
        #{child_markup}
      </ul>"
    end

    def headers_markup(page)
      return '' if page.headers.nil? || page.headers.empty?

      markup = ''

      page.headers.each do |header|
        hash = header[:hash]
        subtitle = header[:title]
        markup << "<li class=\"nav-leaf\"><a href=\"#{page.path}#{hash}\">#{subtitle}</a></li>"
      end

      markup
    end

    def leaf_markup(page)
      item_class = pages.parent.nil? ? 'nav-leaf' : 'nav-leaf nav-subgroup-leaf'
      "<li class=\"#{item_class}\"><a href=\"#{path}\">#{title}</a></li>"
    end
  end
end
