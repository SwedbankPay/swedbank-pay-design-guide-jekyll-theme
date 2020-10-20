# frozen_string_literal: true

require_relative 'sidebar_html_builder'

module SwedbankPay
  # Renders the Sidebar
  class SidebarRenderer
    def render(tree)
      raise ArgumentError, 'pages must be an SidebarTreeBuilder' unless tree.is_a? SidebarTreeBuilder

      @tree = tree
      render_pages(tree)
    end

    private

    def render_pages(pages)
      return if pages.empty?

      pages.each do |page|
        sidebar_html = render_page(page)

        next if sidebar_html.nil?
        next if page.sidebar_container.nil?

        page.sidebar_container.inner_html = sidebar_html

        page.save

        render_pages(page.children)
      end
    end

    def render_page(page)
      sidebar_html = nil

      begin
        builder = SidebarHTMLBuilder.new(@tree)
        sidebar_html = builder.build(page)

        File.open('_site/sidebar.html', 'w') { |f| f.write(sidebar_html) }
      rescue StandardError => e
        Jekyll.logger.error("           Sidebar: Unable to render sidebar for '#{page.filename}'.")
        Jekyll.logger.debug("           Sidebar: #{e.message}. #{e.backtrace.inspect}")
        nil
      end

      sidebar_html
    end
  end
end
