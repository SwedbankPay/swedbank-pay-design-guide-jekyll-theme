# frozen_string_literal: true

require_relative 'sidebar_logger'
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
        unless page.filename.include?('404.html')
          sidebar_html = render_sidebar(page)
          name = page.filename || page.name || page.to_s

          if sidebar_html.nil?
            SidebarLogger.warn("No HTML rendered for #{name}.")
            next
          end

          if page.sidebar_container.nil?
            SidebarLogger.warn("No sidebar container found in '#{name}'. #{page.filename}")
            next
          end

          page.sidebar_container.inner_html = sidebar_html
        end

        page.save

        render_pages(page.children)
      end
    end

    def render_sidebar(page)
      sidebar_html = nil

      begin
        sidebar_html = @html_builder.build(page)

        File.write('_site/sidebar.html', sidebar_html)
      rescue StandardError => e
        name = page.filename || page.name || page.to_s
        SidebarLogger.error("Unable to render sidebar for '#{name}'.")
        SidebarLogger.debug("#{e.message}. #{e.backtrace.inspect}")
      end

      sidebar_html
    end
  end
end
