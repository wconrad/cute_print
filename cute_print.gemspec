# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require File.join(File.dirname(__FILE__), "lib/cute_print/release")

class Readme

  def description
    readme = File.open(README_PATH, "r", &:read)
    description = readme[/^# cute_print.*\n+((?:.*\n)+?)\n*##/i, 1]
    unless description
      raise "Unable to extract description from readme"
    end
    description = remove_badges(description)
    description = remove_markdown_link(description)
    description = join_lines(description)
    description
  end

  private

  README_PATH = File.expand_path("README.md", File.dirname(__FILE__))
  private_constant :README_PATH
  
  def remove_markdown_link(description)
    regex = %r{
    \[
      ([^\]]+)
    \]
    (
      \[\d+\] |
      \([^)]+\)
    )
    }x
    description.gsub(regex, '\1')
  end

  def remove_badges(description)
    description.gsub(/^\[!.*\n/, "")
  end

  def join_lines(description)
    description.gsub(/\n/, " ").strip
  end

end

readme = Readme.new

Gem::Specification.new do |s|
  s.name = "cute_print"
  s.version = CutePrint::Release::VERSION
  s.required_rubygems_version = Gem::Requirement.new(">= 0")
  s.require_paths = ["lib"]
  s.authors = ["Wayne Conrad"]
  s.date = CutePrint::Release::DATE
  s.description = readme.description
  s.email = "kf7qga@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "Gemfile",
    "LICENSE",
    "README.md",
    "Rakefile",
    "cute_print.gemspec",
  ]
  s.files += Dir["lib/**/*.rb"]
  s.homepage = "http://github.com/wconrad/cute_print"
  s.licenses = ["MIT"]
  s.required_ruby_version = ">= 1.9.3"
  s.rubygems_version = "2.5.1"
  s.summary = "print debug to stderr, with flair"
  s.specification_version = 4
  s.add_development_dependency("cucumber", "~> 2.0")
  s.add_development_dependency("rake", "~> 12.0")
  s.add_development_dependency("redcarpet", "~> 3.2")
  s.add_development_dependency("rspec", "~> 3.1")
  s.add_development_dependency("rspec-given", "~> 3.5")
  s.add_development_dependency("yard", "~> 0.9.9")
  s.add_runtime_dependency("ruby2ruby", "~> 2.1")
  s.add_runtime_dependency("ruby_parser", "~> 3.6")
end

