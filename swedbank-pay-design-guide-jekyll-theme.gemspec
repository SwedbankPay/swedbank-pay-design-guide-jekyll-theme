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
  spec.metadata      = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true'
  }

  spec.required_ruby_version = '>= 2.5.0'
  spec.add_runtime_dependency 'faraday', '>= 1.0.1', '< 3'
  spec.add_runtime_dependency 'jekyll', '>= 3.7', '< 5.0'
  spec.add_runtime_dependency 'jekyll-contentblocks', '~> 1', '>= 1.2'
  spec.add_runtime_dependency 'jekyll-material-icon-tag', '~> 1', '>= 1.1'
  spec.add_runtime_dependency 'jekyll-redirect-from', '~> 0.16'
  spec.add_runtime_dependency 'jemoji', '~> 0.12'
  spec.add_runtime_dependency 'kramdown-plantuml', '~> 1', '>= 1.3.2'
  spec.add_runtime_dependency 'nokogiri', '~> 1.11'
  spec.add_runtime_dependency 'sass', '~> 3', '>= 3.7'
  spec.add_runtime_dependency 'awesome_print'

  spec.add_development_dependency 'bundler', '~> 2', '>= 2.2'
  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'html-proofer', '>= 3.19', '< 6'
  spec.add_development_dependency 'html-proofer-unrendered-markdown', '>= 0.2'
  spec.add_development_dependency 'its'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-html-matchers'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'awesome_print'
end
