module EnvUtil

  extend self

  # Set environment variables for the duration of the block, then
  # restore them to their original value.
  # @param h [Hash]
  def set(h)
    orig = {}
    h.keys.each do |key|
      orig[key] = ENV[key]
    end
    begin
      h.each do |key, value|
        ENV[key] = value.to_s
      end
      yield
    ensure
      orig.each do |key, value|
        ENV[key] = value
      end
    end
  end

end

Around do |scenario, block|
  EnvUtil.set("CUTE_PRINT_TERM_WIDTH" => 79) do
    block.call
  end
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
