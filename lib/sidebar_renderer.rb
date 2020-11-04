# frozen_string_literal: true

require_relative 'sidebar_html_builder'

module SwedbankPay
  # Renders the Sidebar
  class SidebarRenderer
    def initialize(tree)
      raise ArgumentError, 'pages cannot be nil' if tree.nil?
      raise ArgumentError, 'pages must be an SidebarTreeBuilder' unless tree.is_a? SidebarTreeBuilder

      @tree = tree
      @html_builder = SidebarHTMLBuilder.new(@tree)
    end

    def enrich_jekyll
      enrich_jekyll_pages(@tree)
    end

    def render
      render_pages(@tree)
    end

    private

    def render_pages(pages)
      return if pages.empty?

      pages.each do |page|
        sidebar_html = render_sidebar(page)
        name = page.filename || page.name || page.to_s

        if sidebar_html.nil?
          Jekyll.logger.warn("           Sidebar: No HTML rendered for #{name}.")
          next
        end

        if page.sidebar_container.nil?
          Jekyll.logger.warn("           Sidebar: No sidebar container found in '#{name}'. #{page.filename}")
          next
        end

        page.sidebar_container.inner_html = sidebar_html

        page.save

        render_pages(page.children)
      end
    end

    def render_sidebar(page)
      sidebar_html = nil

      begin
        sidebar_html = @html_builder.build(page)

        File.open('_site/sidebar.html', 'w') { |f| f.write(sidebar_html) }
      rescue StandardError => e
        name = page.filename || page.name || page.to_s
        Jekyll.logger.error("           Sidebar: Unable to render sidebar for '#{name}'.")
        Jekyll.logger.debug("           Sidebar: #{e.message}. #{e.backtrace.inspect}")
      end

      sidebar_html
    end
  end
end
