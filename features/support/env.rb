require "rspec/expectations"

# Instead of letting cucumber load all of the .rb, we configure
# cucumber to require them (see .config/cucumber.yml).
glob = File.join(File.dirname(__FILE__), '**/*.rb')
ruby_paths = Dir[glob].sort
ruby_paths.each do |path|
  require path
end
