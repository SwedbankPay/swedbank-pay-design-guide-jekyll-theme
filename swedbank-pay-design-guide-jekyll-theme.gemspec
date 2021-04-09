# frozen_string_literal: true

require 'json'
require_relative './lib/gem_version'

Gem::Specification.new do |spec|
  spec.name          = 'swedbank-pay-design-guide-jekyll-theme'
  spec.version       = Gem::Specification.gem_version
  spec.authors       = ['Swedbank Pay']
  spec.email         = ['opensource@swedbankpay.com']

  spec.summary       = 'Swedbank Pay Design Guide theme for Jekyll'
  spec.homepage      = 'https://github.com/SwedbankPay/swedbank-pay-design-guide-jekyll-theme'
  spec.license       = 'Apache-2.0'

  file_filter        = /^(assets|_layouts|_includes|_sass|_plugins|_assets|lib|LICENSE|README)/i
  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(file_filter) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5.0'
  spec.add_runtime_dependency 'faraday', '>= 1.0.1'
  spec.add_runtime_dependency 'html-proofer'
  spec.add_runtime_dependency 'jekyll', '>= 3.7', '< 5.0'
  spec.add_runtime_dependency 'jekyll-contentblocks'
  spec.add_runtime_dependency 'jekyll-material-icon-tag'
  spec.add_runtime_dependency 'jekyll-redirect-from'
  spec.add_runtime_dependency 'jemoji'
  spec.add_runtime_dependency 'kramdown-plantuml'
  spec.add_runtime_dependency 'nokogiri', '~> 1.11'
  spec.add_runtime_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'sass'

  spec.add_development_dependency 'bundler'
end
