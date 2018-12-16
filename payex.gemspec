# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "payex"
  spec.version       = "0.1.0"
  spec.authors       = ["Asbjørn Ulsberg"]
  spec.email         = ["asbjorn@ulsberg.no"]

  spec.summary       = "PayEx Design Guide theme for Jekyll"
  spec.homepage      = "https://github.com/PayEx/payex-design-guide-jekyll-theme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "jekyll", "~> 3.7"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
end
