# frozen_string_literal: false

require_relative 'sidebar_logger'
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
        current_page_name = current_page.respond_to?(:name) ? current_page.name : current_page.to_s

        if page.hidden_for?(current_page)
          SidebarLogger.debug("#{page.name} is hidden for #{current_page_name}")
          next
        elsif page.hidden?
          SidebarLogger.debug("Hidden page #{page.name} is not hidden for #{current_page_name}")
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
      title_markup = title_markup(page, level, is_leaf)
      item_class = item_class(page, current_page, level, is_leaf)
      root_class = root_class(page, current_page)
      level.zero? &&
        page.doc.xpath('//*[@id="dg-sidebar"]').first.set_attribute('class', root_class)
      "<li class=\"#{item_class}\">
          #{title_markup}
          #{item_class === 'main-nav-li' || item_class === 'main-nav-li active' ? "<nav class=\"sidebar-secondary-nav\">
              <header class=\"secondary-nav-header\">#{page.title.section || page.title}</header>
                #{sub_items_markup}
              </nav>" : sub_items_markup}
        </li>"
    end

    def root_class(page, current_page)
      active = page.active?(current_page)
      active && current_page.path != '/' ? 'sidebar dg-sidebar has-secondary-nav' : 'sidebar dg-sidebar'
    end

    def item_class(page, current_page, level, is_leaf)
      active = page.active?(current_page, is_leaf: is_leaf)
      item_class = group_class(level)
      if item_class != 'main-nav-li'
        item_class += page.children.empty? ? ' group' : ' leaf'
      end

      item_class += ' active' if active
      item_class
    end

    def group_class(level)
      if level.zero?
        'main-nav-li'
      elsif level == 1
        'secondary-nav-li'
      else
        ''
      end
    end

    def group_heading_class(level)
      group_class = group_class(level)
      "#{group_class}-heading"
    end

    def title_markup(page, level, is_leaf)
      lead_title = lead_title(page)
      return "<a href=\"#{page.path}\"><i class=\"material-icons-outlined\" aria-hidden=\"true\">#{page.icon}</i>#{lead_title}</a>" if level.zero? && lead_title != 'Home'
      return "<a href=\"#{page.path}\">#{page.section || page.title}</a>" if lead_title != 'Home'

      main_title = main_title(page, is_leaf)
      home = main_title == 'Home' ? 'disabled' : ''
      "<a class=\"#{home}\" href=\"#{page.path}\"><i class=\"material-icons-outlined\" aria-hidden=\"true\">#{page.icon}</i>#{main_title}</a>"
    end

    def sub_items_markup(page, current_page)
      headers_markup = headers_markup(page, current_page)
      child_markup = build_markup(page.children, current_page)
      return '' if headers_markup.empty? && child_markup.empty?

      "<ul class=\"#{page.level.zero? ? 'secondary-nav-ul' : ''}\">
          #{if page.level.positive? && page.children?
              "<a href=\"#\" class=\"previous-nav\">
                <i class=\"material-icons\" aria-hidden=\"true\">arrow_back_ios</i>
                <span>Back to #{page.parent.title}</span>
              </a>
              <header>#{page.title.section || page.title}</header>"
            end}
          #{headers_markup}
          #{child_markup}
      </ul>"
    end

    def headers_markup(page, current_page)
      # If there's no page headers, only return a leaf item for the page itself.
      return '' unless page.headers?

      # If there's no children, only return the headers as leaf node items.
      return page.headers.map { |h| header_markup(page, h) }.join unless page.children?

      headers_markup = page.headers.map { |h| header_markup(page, h) }.join
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
      leaf_class = level.positive? ? 'leaf' : 'nav-leaf'
      "<li class=\"#{leaf_class}\"><a href=\"#{href}\">#{title}</a></li>"
    end

    def lead_title(page)
      return page.title.lead unless page.title.nil? || page.title.lead.nil?
      return page.parent.title.to_s unless page.parent.nil? || page.parent.title.nil?

      ''
    end

    def main_title(page, is_leaf)
      unless page.nil? || page.title.nil?
        lead_title = lead_title(page)
        parent_lead_title = parent_lead_title(page)
        main_title = page.title.main

        # If the lead title is different to the parent's or we're not on a leaf
        # node item, use the lead title as the main title. This causes 'section: Card'
        # to be used as title for the Card item, but allows the nav-subgroup-heading
        # 'Introduction' item to use the main title 'Introduction'.
        main_title = lead_title unless lead_title == parent_lead_title || is_leaf

        return main_title || page.title.to_s
      end

      ''
    end

    def parent_lead_title(page)
      return page.parent.title.lead unless page.parent.nil? || page.parent.title.nil?

      nil
    end
  end
end
