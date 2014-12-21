# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: cute_print 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "cute_print"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Wayne Conrad"]
  s.date = "2014-12-21"
  s.description = "Write debug output to stderr.  Optionally print the source filename and line number, or the source of the debug statement.  Easily inspect the middle of a call chain."
  s.email = "wconrad@yagni.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".config/cucumber.yml",
    ".rspec",
    ".travis.yml",
    ".yardopts",
    "CHANGELOG.md",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "cute_print.gemspec",
    "features/.nav",
    "features/call_chain.feature",
    "features/configuring/configure_output.feature",
    "features/configuring/configure_position_format.feature",
    "features/configuring/readme.md",
    "features/configuring/reset_configuration.feature",
    "features/inspect/core.feature",
    "features/inspect/inspect.feature",
    "features/inspect/inspect_with_location.feature",
    "features/inspect/inspect_with_source.feature",
    "features/inspect/readme.md",
    "features/pretty_print/pretty_print.feature",
    "features/pretty_print/pretty_print_with_location.feature",
    "features/pretty_print/pretty_print_with_source.feature",
    "features/readme.md",
    "features/support/env.rb",
    "features/support/helpers/example.rb",
    "features/support/helpers/example_runner.rb",
    "features/support/helpers/fork_example_runner.rb",
    "features/support/helpers/lib_path.rb",
    "features/support/helpers/shell_example_runner.rb",
    "features/support/helpers/temp_dir.rb",
    "features/support/step_definitions.rb",
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
    "lib/cute_print/values.rb",
    "spec/cute_print_spec.rb",
    "spec/format/inspect_spec.rb",
    "spec/format/pretty_print_spec.rb",
    "spec/inline_labeler_spec.rb",
    "spec/irb_spec.rb",
    "spec/labeler_spec.rb",
    "spec/outline_labeler_spec.rb",
    "spec/printer_spec.rb",
    "spec/silence_warnings.rb",
    "spec/spec_helper.rb",
    "spec/support/captures_stderr.rb",
    "tasks/cucumber.rake",
    "tasks/default.rake",
    "tasks/jeweler.rake",
    "tasks/spec.rake",
    "tasks/test.rake",
    "tasks/yard.rake",
    "test_support/captures_stderr.rb",
    "test_support/captures_stdout.rb",
    "test_support/thread_unsafe_string_io.rb"
  ]
  s.homepage = "http://github.com/wconrad/cute_print"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.4"
  s.summary = "print debug to stderr, with flair"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby_parser>, ["~> 3.6"])
      s.add_runtime_dependency(%q<ruby2ruby>, ["~> 2.1"])
    else
      s.add_dependency(%q<ruby_parser>, ["~> 3.6"])
      s.add_dependency(%q<ruby2ruby>, ["~> 2.1"])
    end
  else
    s.add_dependency(%q<ruby_parser>, ["~> 3.6"])
    s.add_dependency(%q<ruby2ruby>, ["~> 2.1"])
  end
end

