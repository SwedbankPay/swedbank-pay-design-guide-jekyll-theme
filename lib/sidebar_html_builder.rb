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

        sub_items_markup = sub_items_markup(page, current_page)
        markup << item_markup(page, current_page, page.level, sub_items_markup)
      end

      markup
    end

    def item_markup(page, current_page, level, sub_items_markup)
      title_markup = title_markup(page, level)
      item_class = item_class(page, current_page, level)
      group_class = group_class(level)

      "<li class=\"#{item_class}\">
        <div class=\"#{group_class}\">
          <i class=\"material-icons\">arrow_right</i>
          #{title_markup}
        </div>
        #{sub_items_markup}
      </li>"
    end

    def item_class(page, current_page, level)
      cls = level.zero? ? 'nav-group' : 'nav-subgroup'
      cls += ' active' if page.active?(current_page)
      cls
    end

    def group_class(level)
      group = level.zero? ? 'group' : 'subgroup'
      "nav-#{group}-heading"
    end

    def title_markup(page, level)
      return "<span>#{page.title.section}</span>" if level.zero?

      "<a href=\"#{page.path}\">#{page.title.item}</a>"
    end

    def sub_items_markup(page, current_page)
      headers_markup = headers_markup(page, current_page)
      child_markup = build_markup(page.children, current_page)

      return '' if headers_markup.empty? && child_markup.empty?

      "<ul class=\"nav-ul\">
        #{headers_markup}
        #{child_markup}
      </ul>"
    end

    def headers_markup(page, current_page)
      # If there's no page headers, only return a leaf item for the page itself.
      return leaf_markup(page.path, page.title.item, page.level) if page.headers.empty?

      # If there's no children, only return the headers as leaf node items.
      return page.headers.map { |h| header_markup(page, h) }.join('') if page.children.empty?

      headers_markup = page.headers.map { |h| header_markup(page, h) }.join('')
      headers_markup = "<ul class=\"nav-ul\">#{headers_markup}</ul>"

      item_markup(page, current_page, page.level + 1, headers_markup)
    end

    def header_markup(page, header)
      hash = header[:hash]
      subtitle = header[:title]
      href = "#{page.path}#{hash}"
      leaf_markup(href, subtitle)
    end

    def leaf_markup(href, title, level = 0)
      leaf_class = level.positive? ? 'nav-leaf nav-subgroup-leaf' : 'nav-leaf'
      "<li class=\"#{leaf_class}\"><a href=\"#{href}\">#{title}</a></li>"
    end
  end
end
