require "jekyll"
require "nokogiri"
require 'json'

Jekyll::Hooks.register :site, :post_write do | site |
  File.open("site.log", 'w') { |file| file.write(site.inspect) }

  Dir.glob("#{site.config["destination"]}/**/*.html") do | filename |
    puts filename
  end

end
