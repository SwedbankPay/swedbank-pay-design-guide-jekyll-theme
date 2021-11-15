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
        current_page_name = current_page.respond_to?(:name) ? current_page.name : current_page.to_s

        if page.hidden_for?(current_page)
          Jekyll.logger.debug("           Sidebar: #{page.name} is hidden for #{current_page_name}")
          next
        elsif page.hidden?
          Jekyll.logger.debug("           Sidebar: Hidden page #{page.name} is not hidden for #{current_page_name}")
        end

        sub_items_markup = sub_items_markup(page, current_page)
        markup << main_item(page, current_page)
      end

      markup
    end

    def main_item(page, current_page)
      secondary_item = page.children ? secondary_item(page, current_page) : ''
      main_li = (current_page.path.include?(page.path) and page.path != '/') ? 'main-nav-li active' : 'main-nav-li'
      "<li class=\"#{main_li}\">
      <a aria-current=\"page\" class=\"\" href=\"#{page.path}\"><i class=\"material-icons-outlined\">home</i>#{page.title}</a>
      #{secondary_item}
      </li>"
    end

    def secondary_item(page, current_page)
      secondary_nav_li = children(page, current_page)
      "<nav class=\"sidebar-secondary-nav\">
        <header class=\"secondary-nav-header\">#{page.title}
        </header>
        <ul class=\"secondary-nav-ul extended-sidebar\">
          #{secondary_nav_li}
        </ul>
      </nav>"

    end

    def children (page, current_page)
      list_children = ''
      page.children.each do |child|
        secondary_li = (current_page.path.include?(child.path)) ? 'secondary-nav-li group active' : 'secondary-nav-li group'
        tertiary_li = grand_children(child.children, current_page)
        child_markup = 
          "<li class=\"#{secondary_li}\">
          <a href=\"#{child.path}\">
          #{child.title} </a>
            <ul class=\"tertiary-nav-ul\">
              <a href=#{page.path} class=\"icon-link text-decoration-none previous-nav\">
                <i class=\"material-icons\" aria-hidden=\"true\">arrow_back_ios</i>
                <span class=\"ml-2\">Back to #{page.title}</span>
              </a>
              <header class=\"tertiary-nav-header mt-2\">
                <i class=\"material-icons-outlined rotated\">palette</i>#{child.title}
              </header>
              #{tertiary_li}
            </ul>
          </li>"

      list_children << child_markup

      end

      list_children

    end

    def grand_children (child_children, current_page)
      list_grandchildren = ''
      child_children.each do |grandchild|
        tertiary_nav_li = (current_page.path.include?(grandchild.path)) ? 'tertiary-nav-li group active' : 'tertiary-nav-li group'
        quarternary_li = great_grand_children(grandchild.children, current_page)
        grandchild_markup = 
          "<li class=\"#{tertiary_nav_li}\">
            <a href=\"#{grandchild.path}\">#{grandchild.title}</a>
              <ul class=\"quarternary-nav-ul\">
                #{quarternary_li}
              </ul>
          </li>"

        list_grandchildren << grandchild_markup

      end

      list_grandchildren

    end

    def great_grand_children(child_grandchildren, current_page)
      list_great_grandchildren = ''
      child_grandchildren.each do |great_grandchild|
        quarternary_nav_leaf = (current_page.path.include?(great_grandchild.path)) ? 'nav-leaf active' : 'nav-leaf'
        great_grandchild_markup = 
        "<li class=\"#{quarternary_nav_leaf}\">
          <a href=\"#{great_grandchild.path}\">#{great_grandchild.title}</a>
        </li>"

        list_great_grandchildren << great_grandchild_markup

      end

      list_great_grandchildren

    end

    def item_markup(page, current_page, sub_items_markup, is_leaf)
      # If we're rendering a leaf node, just set the level to a non-zero value
      # to get the 'nav-subgroup' class and such.
      level = is_leaf ? -1 : page.level
      title_markup = title_markup(page, level, is_leaf)
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

    def title_markup(page, level, is_leaf)
      lead_title = lead_title(page)
      return "<span>#{lead_title}</span>" if level.zero?

      main_title = main_title(page, is_leaf)

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
      return page.headers.map { |h| header_markup(page, h) }.join('') unless page.children?

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
