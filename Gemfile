source 'https://rubygems.org'

# cut patch number off the version number and lock it down to the minor version
ruby_version = File.read(File.expand_path('.ruby-version', __dir__)).chomp.split('.')[0..1].join('.')
ruby "~> #{ruby_version}"

# Specify your gem's dependencies in eligible.gemspec
gemspec
