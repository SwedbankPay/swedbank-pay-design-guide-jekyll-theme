# frozen_string_literal: true

require 'jekyll_asset_pipeline'

module JekyllAssetPipeline
  # Converts .scss files to CSS.
  class SassConverter < JekyllAssetPipeline::Converter
    require 'sass'

    def self.filetype
      '.scss'
    end

    def convert
      return Sass::Engine.new(@content, syntax: :scss, load_paths: [@dirname]).render
    end
  end
end
