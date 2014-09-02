# encoding: utf-8

require 'jeweler'

def readme
  File.read(File.join(File.dirname(__FILE__), '../README.md'))
end

def remove_badges(s)
  s.gsub(/^\[![^\n]+\n/, '')
end

def join_lines(s)
  s.gsub(/\n/, ' ').strip
end

def description
  unless (desc = readme[/\A#[^\n]*\n*(.*?)\n*^#/m, 1])
    raise "Failed to extract description from readme"
  end
  desc = remove_badges(desc)
  desc = join_lines(desc)
  desc
end

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see
  # http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = 'cute_print'
  gem.homepage = 'http://github.com/wconrad/cute_print'
  gem.license = 'MIT'
  gem.summary = %Q{print debug to stderr, with flair}
  gem.description = description
  gem.email = 'wconrad@yagni.com'
  gem.authors = ['Wayne Conrad']
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new
