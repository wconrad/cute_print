require "rspec/expectations"

# Instead of letting cucumber load all of the .rb, we configure
# cucumber to require them (in .config/cucumber.yml)

glob = File.join(File.dirname(__FILE__), '**/*.rb')
Dir[glob].sort.each do |path|
  require path
end
