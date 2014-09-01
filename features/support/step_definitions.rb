require_relative "../../lib/print_debug"

Before do
  PrintDebug::Configure.reset
end

Given(/^a file with:$/) do |contents|
  @example = Example.new(contents)
  @example.run
end

Given(/^a file named "(.*?)" with:$/) do |filename, contents|
  @example = Example.new(contents, :filename => filename)
  @example.run
end

Then(/^stderr should be$/) do |expected|
  expect(@example.stderr).to eq expected
end

Then(/^stdout should be$/) do |expected|
  expect(@example.stdout).to eq expected
end
