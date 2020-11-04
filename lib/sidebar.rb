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

      def pre_render(site)
        Jekyll.logger.debug("           Sidebar: pre_render")
        @parser = SidebarParser.new(site)
        @pages = SidebarTreeBuilder.new(@parser.pages)
        Jekyll.logger.debug("           Sidebar: #{@pages.inspect}")
      end

      def post_write(site)
        @sidebar_renderer = SidebarRenderer.new(@pages)
        @parser.parse(@pages)
        Jekyll.logger.debug("           Sidebar: post_write")
        @sidebar_renderer.render
      end
    end
  end
end

Jekyll::Hooks.register :site, :pre_render do |site, _|
  SwedbankPay::Sidebar.pre_render site
end

Jekyll::Hooks.register :site, :post_write do |site, _|
  SwedbankPay::Sidebar.post_write site
end
