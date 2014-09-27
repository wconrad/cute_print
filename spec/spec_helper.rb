$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "pp"
require "rspec"
require "rspec-given"

globs = [
  "../test_support",
  "support",
].map do |dir|
  File.join(File.dirname(__FILE__), dir, '**/*.rb')
end
Dir[*globs].each do |path|
  require path
end
