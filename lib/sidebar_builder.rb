# frozen_string_literal: false

module SwedbankPay
  # A nice sidebar
  class SidebarBuilder
    def initialize(filename, pages)
      @filename = filename
      @pages = pages
    end

    def build
      sidebar_markup = ''

      @pages.select { |path, _| path.split('/').length <= 2 }.each do |path, page|
        next if page[:title].nil?
        next if page[:hide_from_sidebar]

        sidebar_markup << generate_main_markup(path, page)
      end

      sidebar_markup
    end

    private

    def generate_main_markup(path, page)
      title = page[:title].split('–').first
      child_pages = @pages.select { |child_path, _| child_path.include?(path) && child_path != path && path != '/' }
      active = @filename.active?(path)
      item_class = active ? 'nav-group active' : 'nav-group'

      sidebar_markup = ''
      sidebar_markup << "<li class=\"#{item_class}\">"
      sidebar_markup << '<div class="nav-group-heading">'
      sidebar_markup << '<i class="material-icons">arrow_right</i>'
      sidebar_markup << "<span>#{title}</span></div>"
      sidebar_markup << '<ul class="nav-ul">'
      sidebar_markup << generate_child_markup(path, page, child_pages, 2)
      sidebar_markup << generate_grand_children_markup(child_pages)
      sidebar_markup << '</ul>'
      sidebar_markup << '</li>'
      sidebar_markup
    end

    def generate_child_markup(path, page, all_child_pages, level)
      title = page[:title].split('–').last.strip

      url = page[:url]
      headers = page[:headers]

      grandchildren = all_child_pages.select do |grandchild_path, _|
        grandchild_path.include?(path) \
        && grandchild_path != path \
        && path.split('/').length > level
      end

      sub_group_markup = ''
      has_child_pages = !all_child_pages.empty?

      if (!headers.nil? && headers.any?) || !grandchildren.empty?
        if has_child_pages
          active = @filename.active?(url, exact: true)
          item_class = active || (url.split('/').length > level && @filename.start_with?(url)) ? 'nav-subgroup active' : 'nav-subgroup'
          sub_group_markup << "<li class=\"#{item_class}\">"
          sub_group_markup << '<div class="nav-subgroup-heading">'
          sub_group_markup << '<i class="material-icons">arrow_right</i>'
          sub_group_markup << "<a href=\"#{url}\">#{title}</a>"
          sub_group_markup << '</div>'
          sub_group_markup << '<ul class="nav-ul">'

          if grandchildren.empty?
            headers.each do |header|
              hash = header[:hash]
              subtitle = header[:title]
              sub_group_markup << "<li class=\"nav-leaf\"><a href=\"#{url}#{hash}\">#{subtitle}</a></li>"
            end
          else
            sub_group_leaf_class = active ? 'nav-leaf nav-subgroup-leaf active' : 'nav-leaf nav-subgroup-leaf'
            sub_group_markup << "<li class=\"#{sub_group_leaf_class}\"><a href=\"#{url}\">#{title} overview</a></li>"

            grandchildren.each do |grandchild_path, grandchild_page|
              sub_group_markup << generate_child_markup(grandchild_path, grandchild_page, grandchildren, 3)
            end
          end

          sub_group_markup << '</ul>'
          sub_group_markup << '</li>'
        else
          headers.each do |header|
            hash = header[:hash]
            subtitle = header[:title]
            sub_group_markup << "<li class=\"nav-leaf\"><a href=\"#{url}#{hash}\">#{subtitle}</a></li>"
          end
        end
      else
        sub_group_markup << if has_child_pages
                              "<li class=\"nav-leaf nav-subgroup-leaf\"><a href=\"#{url}\">#{title}</a></li>"
                            else
                              "<li class=\"nav-leaf\"><a href=\"#{url}\">#{title}</a></li>"
                            end
      end

      sub_group_markup
    end

    def generate_grand_children_markup(pages)
      markup = ''
      return markup unless pages.any?

      pages.select { |child_path, _| child_path.split('/').length <= 3 }.each do |child_path, child_page|
        next if child_page[:title].nil?
        next if child_page[:hide_from_sidebar]

        markup << generate_child_markup(child_path, child_page, pages, 2)
      end

      markup
    end
  end
end
