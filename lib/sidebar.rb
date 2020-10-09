# frozen_string_literal: false

require 'jekyll'
require 'nokogiri'
require 'json'
require_relative 'sidebar_page'
require_relative 'sidebar_parser'
require_relative 'sidebar_renderer'
require_relative 'sidebar_tree_builder'

module SwedbankPay
  # A nice sidebar
  module Sidebar
    class << self
      attr_reader :pages

      def init
        @pages = {}
      end

      def pre_render(page)
        sidebar_page = SidebarPage.new(page)
        @pages[sidebar_page.path] = sidebar_page
      end

      def post_write(site)
        parser = SidebarParser.new(site)
        pages = parser.parse(@pages)
        tree = SidebarTreeBuilder.new(pages)
        renderer = SidebarRenderer.new
        renderer.render(tree)
      end
    end
  end
end

SwedbankPay::Sidebar.init

Jekyll::Hooks.register :site, :pre_render do |site, _|
  site.pages.each do |page|
    SwedbankPay::Sidebar.pre_render page
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  SwedbankPay::Sidebar.post_write site
end
