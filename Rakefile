# frozen_string_literal: true

require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'jekyll'
require 'html-proofer'

# Extend string to allow for bold text.
class String
  def bold
    "\033[1m#{self}\033[0m"
  end
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/*_spec.rb')
  t.rspec_opts = '--format documentation'
end

desc 'Runs RuboCop'
desc task :rubocop do
  RuboCop::RakeTask.new
end

namespace :codecov do
  desc 'Uploads the latest SimpleCov result set to codecov.io'
  task :upload do
    require 'simplecov'
    require 'codecov'

    formatter = SimpleCov::Formatter::Codecov.new
    formatter.format(SimpleCov::ResultMerger.merged_result)
  end
end

# Rake Jekyll tasks
task :build do
  puts 'Building site...'.bold
  Jekyll::Commands::Build.process(profile: true)
end

task :clean do
  puts 'Cleaning up _site...'.bold
  Jekyll::Commands::Clean.process({})
end

# Test generated output has valid HTML and links.
task test: :build do
  options = { assume_extension: true }
  HTMLProofer.check_directory('./_site', options).run
end

task default: ['build']
