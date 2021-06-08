module Jekyll
  # Applies environment variables to the site config.
  class EnvGenerator < Generator
    def generate(site)
      site.config["env"] = ENV["JEKYLL_ENV"] || "development"
    end
  end
end
