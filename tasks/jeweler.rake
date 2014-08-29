# encoding: utf-8

require 'jeweler'

def readme
  File.read(File.join(File.dirname(__FILE__), '../README.md'))
end

def description
  unless (desc = readme[/\A#[^\n]*\n*(.*?)\n*^#/m, 1])
    raise "Failed to extract description from readme"
  end
  desc.gsub(/\n/, ' ').strip
end

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see
  # http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = 'print_debug'
  gem.homepage = 'http://github.com/wconrad/print_debug'
  gem.license = 'MIT'
  gem.summary = %Q{print debug to stderr, with flair}
  gem.description = description
  gem.email = 'wconrad@yagni.com'
  gem.authors = ['Wayne Conrad']
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new
