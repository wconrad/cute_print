Given(/^a file with:$/) do |contents|
  @example = Example.new(contents)
  @example.run
end

Given(/^a file named "(.*?)" with:$/) do |filename, contents|
  @example = Example.new(contents, :filename => filename)
  @example.run
end

Then(/^stderr should be$/) do |expected_stderr|
  expect(@example.stderr).to eq expected_stderr
end
