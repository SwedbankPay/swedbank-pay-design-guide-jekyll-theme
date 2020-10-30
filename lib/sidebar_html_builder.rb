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

      current_path = current_path(current_page)
      markup = ''

      pages.each do |page|
        next if page.ignore?

        sub_items_markup = sub_items_markup(page, current_path)
        markup << item_markup(page, current_path, page.level, sub_items_markup)
      end

      markup
    end

    def current_path(current_page)
      if current_page.nil?
        Jekyll.logger.warn('           Sidebar: Nil current_page')
        return ''
      end

      return current_page if current_page.is_a? String
      return current_page.path if current_page.respond_to?(:path)

      Jekyll.logger.warn("           Sidebar: #{current_page.class} ('#{current_page}') does not respond to :path.")

      ''
    end

    def item_markup(page, current_path, level, sub_items_markup)
      title_markup = title_markup(page, level)
      item_class = item_class(page, current_path, level)
      group_heading_class = group_heading_class(level)

      "<li class=\"#{item_class}\">
        <div class=\"#{group_heading_class}\">
          <i class=\"material-icons\">arrow_right</i>
          #{title_markup}
        </div>
        #{sub_items_markup}
      </li>"
    end

    def item_class(page, current_path, level)
      active = active?(page, current_path, level)
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
      section_title = section_title(page)
      return "<span>#{section_title}</span>" if level.zero?

      item_title = item_title(page)
      "<a href=\"#{page.path}\">#{item_title}</a>"
    end

    def sub_items_markup(page, current_path)
      headers_markup = headers_markup(page, current_path)
      child_markup = build_markup(page.children, current_path)

      return '' if headers_markup.empty? && child_markup.empty?

      "<ul class=\"nav-ul\">
        #{headers_markup}
        #{child_markup}
      </ul>"
    end

    def headers_markup(page, current_path)
      # If there's no page headers, only return a leaf item for the page itself.
      return leaf_markup(page.path, page.title.item, page.level) unless page.headers?

      # If there's no children, only return the headers as leaf node items.
      return page.headers.map { |h| header_markup(page, h) }.join('') if page.children.empty?

      headers_markup = page.headers.map { |h| header_markup(page, h) }.join('')
      headers_markup = "<ul class=\"nav-ul\">#{headers_markup}</ul>"

      item_markup(page, current_path, page.level + 1, headers_markup)
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

    def active?(page, current_path, level)
      level.zero? ? page.active?(current_path) : page.path == current_path
    end

    def section_title(page)
      return page.title.section unless page.title.section.nil?
      return page.parent.title.to_s unless page.parent.nil? || page.parent.title.nil?

      ''
    end

    def item_title(page)
      page.title.item
    end
  end
end
