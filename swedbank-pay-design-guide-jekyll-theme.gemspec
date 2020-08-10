# frozen_string_literal: true

gem_version = "0.0.1.gemversionnotset"

if ENV.has_key?("GEM_VERSION")
  gem_version = ENV["GEM_VERSION"]
  puts "Environment variable GEM_VERSION used with value: #{gem_version}."
else
  puts "No Environment variable for GEM_VERSION found. Fallback value: #{gem_version}."
end

Gem::Specification.new do |spec|
  spec.name          = 'swedbank-pay-design-guide-jekyll-theme'
  spec.version       = "#{gem_version}"
  spec.authors       = ['Swedbank Pay']
  spec.email         = ['opensource@swedbankpay.com']

  spec.summary       = 'Swedbank Pay Design Guide theme for Jekyll'
  spec.homepage      = 'https://github.com/SwedbankPay/swedbank-pay-design-guide-jekyll-theme'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(/^(assets|_layouts|_includes|_sass|_plugins|_assets|lib|LICENSE|README)/i) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'jekyll', '>= 3.7', '< 5.0'
  spec.add_runtime_dependency 'jekyll-assets'
  spec.add_runtime_dependency 'jekyll-github-metadata'
  spec.add_runtime_dependency 'jekyll-material-icon-tag'
  spec.add_runtime_dependency 'jemoji'
  spec.add_runtime_dependency 'sass'
  spec.add_runtime_dependency 'faraday', '>= 1.0.1'
  spec.add_runtime_dependency 'html-proofer'
  spec.add_runtime_dependency 'kramdown-plantuml'
  spec.add_runtime_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.10'

  spec.add_development_dependency 'bundler'
end
