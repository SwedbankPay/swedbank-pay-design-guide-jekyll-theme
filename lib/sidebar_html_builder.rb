# frozen_string_literal: false

require_relative 'sidebar_page'
require_relative 'sidebar_pages'

module SwedbankPay
  # A nice sidebar
  class SidebarBuilder
    def initialize(filename, pages)
      @filename = filename
      @pages = SidebarPages.new(pages)
    end

    def build
      markup = ''

      @pages.root_pages.each do |page|
        next if page.ignore?

        markup << main_markup(page)
      end

      markup
    end

    private

    def main_markup(page)
      title = page.title.section
      item_class = item_class(path)
      child_markup = child_markup(page, 2)
      grandchildren_markup = generate_grandchildren_markup

      "<li class=\"#{item_class}\">
        <div class=\"nav-group-heading\">
          <i class=\"material-icons\">arrow_right</i>
          <span>#{title}</span>
        </div>
        <ul class=\"nav-ul\">
          #{child_markup}
          #{grandchildren_markup}
        </ul>
      </li>"
    end

    def item_class(path)
      active = @filename.active?(path)
      return 'nav-group active' if active

      'nav-group'
    end

    def child_markup(page, child_pages, level)
      children = SidebarPages.new(child_pages)
      title = page.title.item
      url = page.url
      headers = page.headers
      grandchildren = children.grandchildren_of(path, level)
      markup = ''

      if (!headers.nil? && headers.any?) || !grandchildren.empty?
        markup << grandchild_markup(grandchildren, child_pages, headers, title, url, level)
      else
        item_class = !child_pages.empty? ? 'nav-leaf nav-subgroup-leaf' : 'nav-leaf'
        markup << "<li class=\"#{item_class}\"><a href=\"#{url}\">#{title}</a></li>"
      end

      markup
    end

    def grandchild_markup(grandchildren, child_pages, headers, title, url, level)
      has_child_pages = !child_pages.empty?

      if has_child_pages
        active = @filename.active?(url, exact: true)
        item_class = active || (url.split('/').length > level && @filename.start_with?(url)) ? 'nav-subgroup active' : 'nav-subgroup'
        grand_grandchildren_markup = generate_grand_grandchildren_markup(grandchildren, headers, title, url, active)
        "<li class=\"#{item_class}\">
          <div class=\"nav-subgroup-heading\">
            <i class=\"material-icons\">arrow_right</i>
            <a href=\"#{url}\">#{title}</a>
          </div>
          <ul class=\"nav-ul\">
            #{grand_grandchildren_markup}
          </ul>
        </li>"
      else
        markup = ''

        headers.each do |header|
          hash = header[:hash]
          subtitle = header[:title]
          markup << "<li class=\"nav-leaf\"><a href=\"#{url}#{hash}\">#{subtitle}</a></li>"
        end

        markup
      end
    end

    def generate_grandchildren_markup(pages)
      markup = ''
      return markup unless pages.any?

      pages.select { |child_path, _| child_path.split('/').length <= 3 }.each do |child_path, child_page|
        next if child_page[:title].nil?
        next if child_page[:hide_from_sidebar]

        markup << child_markup(child_path, child_page, pages, 2)
      end

      markup
    end

    def generate_grand_grandchildren_markup(grandchildren, headers, title, url, active)
      markup = ''

      if grandchildren.empty?
        headers.each do |header|
          hash = header[:hash]
          subtitle = header[:title]
          markup << "<li class=\"nav-leaf\"><a href=\"#{url}#{hash}\">#{subtitle}</a></li>"
        end
      else
        sub_group_leaf_class = active ? 'nav-leaf nav-subgroup-leaf active' : 'nav-leaf nav-subgroup-leaf'
        markup << "<li class=\"#{sub_group_leaf_class}\"><a href=\"#{url}\">#{title} overview</a></li>"

        grandchildren.each do |grandchild_path, grandchild_page|
          markup << child_markup(grandchild_path, grandchild_page, grandchildren, 3)
        end
      end

      markup
    end
  end
end
