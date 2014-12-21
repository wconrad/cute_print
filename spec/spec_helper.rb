$VERBOSE=true
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require_relative "silence_warnings"

require "pp"
require "rspec"
silence_warnings do
  require "rspec-given"
end

globs = [
  "../test_support",
  "support",
].map do |dir|
  File.join(File.dirname(__FILE__), dir, '**/*.rb')
end
Dir[*globs].each do |path|
  require path
end
