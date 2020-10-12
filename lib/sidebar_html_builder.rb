# frozen_string_literal: false

require_relative 'sidebar_page'

module SwedbankPay
  # The builder of HTML for the Sidebar
  class SidebarHTMLBuilder
    def initialize(tree)
      @tree = tree
    end

    def build(current_page)
      markup = ''

      @tree.each do |root_page|
        next if root_page.ignore?

        markup << root_markup(root_page, current_page)
      end

      markup
    end

    private

    def root_markup(root_page, current_page)
      title = root_page.title.section
      item_class = item_class(root_page, current_page)
      item_markup = item_markup(root_page, current_page)

      "<li class=\"#{item_class}\">
        <div class=\"nav-group-heading\">
          <i class=\"material-icons\">arrow_right</i>
          <span>#{title}</span>
        </div>
        <ul class=\"nav-ul\">
          #{item_markup}
        </ul>
      </li>"
    end

    def item_class(root_page, current_page)
      active = root_page.active?(current_page)
      return 'nav-group active' if active

      'nav-group'
    end

    def item_markup(page, current_page)
      if page.has_children?
        return child_markup(page, current_page)
      elsif page.has_headers?
        return headers_markup(page)
      else
        return leaf_markup(page)
      end
    end

    def child_markup(page, current_page)
      item_class = page.active?(current_page, exact: true) ? 'nav-subgroup active' : 'nav-subgroup'
      grandchildren_markup = generate_grandchildren_markup(page , current_page)
      return "<li class=\"#{item_class}\">
        <div class=\"nav-subgroup-heading\">
          <i class=\"material-icons\">arrow_right</i>
          <a href=\"#{page.path}\">#{page.title}</a>
        </div>
        <ul class=\"nav-ul\">
          #{grandchildren_markup}
        </ul>
      </li>"
    end

    def headers_markup(page)
      markup = ''

      page.headers.each do |header|
        hash = header[:hash]
        subtitle = header[:title]
        markup << "<li class=\"nav-leaf\"><a href=\"#{page.path}#{hash}\">#{subtitle}</a></li>"
      end

      return markup
    end

    def leaf_markup(page)
      item_class = pages.parent.nil? ? 'nav-leaf' : 'nav-leaf nav-subgroup-leaf'
      "<li class=\"#{item_class}\"><a href=\"#{path}\">#{title}</a></li>"
    end

    def generate_grandchildren_markup(page, current_page)
      markup = ''

      if page.has_headers?
        page.headers.each do |header|
          hash = header[:hash]
          subtitle = header[:title]
          markup << "<li class=\"nav-leaf\"><a href=\"#{page.path}#{hash}\">#{subtitle}</a></li>"
        end
      elsif page.has_children?
        sub_group_leaf_class = active ? 'nav-leaf nav-subgroup-leaf active' : 'nav-leaf nav-subgroup-leaf'
        markup << "<li class=\"#{sub_group_leaf_class}\"><a href=\"#{page.path}\">#{page.title} overview</a></li>"

        page.children.each do |child|
          markup << child_markup(child, current_page)
        end
      end

      markup
    end
  end
end
