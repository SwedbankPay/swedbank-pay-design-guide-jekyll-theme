# frozen_string_literal: false

require_relative 'sidebar_page'

module SwedbankPay
  # The builder of HTML for the Sidebar
  class SidebarHTMLBuilder
    def initialize(tree)
      @tree = tree
    end

    def build(current_page)
      raise ArgumentError, 'current_page cannot be nil' if current_page.nil?
      raise ArgumentError, "#{current_page.class} is not a #{SidebarPage}" unless current_page.is_a? SidebarPage

      build_markup(@tree, current_page)
    end

    private

    def build_markup(pages, current_page)
      return '' if pages.empty?

      markup = ''

      pages.each do |page|
        if page.hidden_for?(current_page)
          name = current_page.respond_to?(:name) ? current_page.name : current_page.to_s
          Jekyll.logger.debug("           Sidebar: #{page.name} is hidden for #{name}")
          next
        end

        sub_items_markup = sub_items_markup(page, current_page)
        markup << item_markup(page, current_page, sub_items_markup, false)
      end

      markup
    end

    def item_markup(page, current_page, sub_items_markup, is_leaf)
      # If we're rendering a leaf node, just set the level to a non-zero value
      # to get the 'nav-subgroup' class and such.
      level = is_leaf ? -1 : page.level
      title_markup = title_markup(page, level)
      item_class = item_class(page, current_page, level, is_leaf)
      group_heading_class = group_heading_class(level)

      "<li class=\"#{item_class}\">
        <div class=\"#{group_heading_class}\">
          <i class=\"material-icons\">arrow_right</i>
          #{title_markup}
        </div>
        #{sub_items_markup}
      </li>"
    end

    def item_class(page, current_page, level, is_leaf)
      active = page.active?(current_page, is_leaf: is_leaf)
      item_class = group_class(level)
      item_class += ' active' if active
      item_class
    end

    def group_class(level)
      level.zero? ? 'nav-group' : 'nav-subgroup'
    end

    def group_heading_class(level)
      group_class = group_class(level)
      "#{group_class}-heading"
    end

    def title_markup(page, level)
      lead_title = lead_title(page)
      return "<span>#{lead_title}</span>" if level.zero?

      main_title = main_title(page)
      "<a href=\"#{page.path}\">#{main_title}</a>"
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
      main_title = page.title.nil? ? nil : page.title.main
      return leaf_markup(page.path, main_title, page.level) unless page.headers?

      # If there's no children, only return the headers as leaf node items.
      return page.headers.map { |h| header_markup(page, h) }.join('') if page.children.empty?

      headers_markup = page.headers.map { |h| header_markup(page, h) }.join('')
      headers_markup = "<ul class=\"nav-ul\">#{headers_markup}</ul>"

      item_markup(page, current_page, headers_markup, true)
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

    def lead_title(page)
      return page.title.lead unless page.title.nil? || page.title.lead.nil?
      return page.parent.title.to_s unless page.parent.nil? || page.parent.title.nil?

      ''
    end

    def main_title(page)
      unless page.nil? || page.title.nil?
        main = page.title.main

        return main || page.title.to_s
      end

      ''
    end
  end
end
