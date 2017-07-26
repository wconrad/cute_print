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
    "lib/cute_print.rb",
    "lib/cute_print/configure.rb",
    "lib/cute_print/core.rb",
    "lib/cute_print/core_ext.rb",
    "lib/cute_print/core_ext/irb.rb",
    "lib/cute_print/core_ext/object.rb",
    "lib/cute_print/cute_print.rb",
    "lib/cute_print/finds_foreign_caller.rb",
    "lib/cute_print/format.rb",
    "lib/cute_print/format/inspect.rb",
    "lib/cute_print/format/pretty_print.rb",
    "lib/cute_print/formatter.rb",
    "lib/cute_print/inline_labeler.rb",
    "lib/cute_print/labeler.rb",
    "lib/cute_print/location.rb",
    "lib/cute_print/location_label.rb",
    "lib/cute_print/location_label/filename.rb",
    "lib/cute_print/location_label/path.rb",
    "lib/cute_print/mixin.rb",
    "lib/cute_print/outline_labeler.rb",
    "lib/cute_print/printer.rb",
    "lib/cute_print/ruby_generator.rb",
    "lib/cute_print/ruby_parser.rb",
    "lib/cute_print/ruby_parser/block.rb",
    "lib/cute_print/ruby_parser/method_call.rb",
    "lib/cute_print/ruby_parser/parsed_code.rb",
    "lib/cute_print/ruby_parser/wraps_sexp.rb",
    "lib/cute_print/source_label.rb",
    "lib/cute_print/stderr_out.rb",
    "lib/cute_print/term_width.rb",
    "lib/cute_print/term_width/detected.rb",
    "lib/cute_print/term_width/static.rb",
    "lib/cute_print/values.rb",
  ]
  s.files += Dir["lib/**/*.rb"]
  s.homepage = "http://github.com/wconrad/cute_print"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "print debug to stderr, with flair"
  s.specification_version = 4
  s.add_development_dependency("cucumber", "~> 2.0")
  s.add_development_dependency("rake", "~> 12.0")
  s.add_development_dependency("redcarpet", "~> 3.2")
  s.add_development_dependency("rspec", "~> 3.1")
  s.add_development_dependency("rspec-given", "~> 3.5")
  s.add_development_dependency("yard", "~> 0.9.9")
  s.add_runtime_dependency("hirb", "~> 0.7")
  s.add_runtime_dependency("ruby2ruby", "~> 2.1")
  s.add_runtime_dependency("ruby_parser", "~> 3.6")
end

