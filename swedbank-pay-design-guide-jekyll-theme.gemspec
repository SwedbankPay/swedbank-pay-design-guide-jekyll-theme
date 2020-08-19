# frozen_string_literal: true
require 'json'

def get_gem_version
  # Required for bundle install
  gem_version = "0.0.1.gemversionnotset"

  version_file = "version.json"
  if File.file? version_file
    json_data = JSON.load(File.open(version_file))
    gem_version = json_data["version"]
  end
  return gem_version
end

Gem::Specification::Class.class_eval { include get_gem_version}

Gem::Specification.new do |spec|
  spec.name          = 'swedbank-pay-design-guide-jekyll-theme'
  spec.version       = get_gem_version
  spec.authors       = ['Swedbank Pay']
  spec.email         = ['opensource@swedbankpay.com']

  spec.summary       = 'Swedbank Pay Design Guide theme for Jekyll'
  spec.homepage      = 'https://github.com/SwedbankPay/swedbank-pay-design-guide-jekyll-theme'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(/^(assets|_layouts|_includes|_sass|_plugins|_assets|lib|LICENSE|README)/i) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'jekyll', '>= 3.7', '< 5.0'
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
