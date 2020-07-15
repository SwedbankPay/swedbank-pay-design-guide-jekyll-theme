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
      load_paths = [
        @dir,
        File.join(__dir__, '_sass'),
        File.join(__dir__, '..', '_assets', 'scss')
      ]
      Sass::Engine.new(@content, syntax: :scss, load_paths: load_paths).render
    end
  end
end
