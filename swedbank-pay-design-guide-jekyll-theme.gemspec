# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "swedbank-pay-design-guide-jekyll-theme"
  spec.version       = "1.0.0"
  spec.authors       = ["Asbjørn Ulsberg"]
  spec.email         = ["asbjorn@ulsberg.no"]

  spec.summary       = "Swedbank Pay Design Guide theme for Jekyll"
  spec.homepage      = "https://github.com/SwedbankPay/swedbank-pay-design-guide-jekyll-theme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "jekyll", ">= 3.7", "< 5.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
