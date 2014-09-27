require "open3"

require_relative "fork_example_runner"
require_relative "shell_example_runner"

class ExampleRunner

  def self.run(*args, &block)
    instance.run(*args, &block)
  end

  def self.instance
    @instance ||= make
  end

  def self.make
    if ForkExampleRunner.supported?
      ForkExampleRunner.new
    else
      ShellExampleRunner.new
    end
  end

end
