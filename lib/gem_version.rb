# frozen_string_literal: true

module Gem
  # The Gem specification
  class Specification
    def self.gem_version
      # Required for bundle install
      gem_version = '0.0.1.no-version'
      version_file = File.join(__dir__, '..', 'version.json')

      if File.file? version_file
        File.open(version_file) do |file|
          json_data = JSON.parse(file)
          gem_version = json_data['version']
        end
      end

      gem_version
    end
  end
end
