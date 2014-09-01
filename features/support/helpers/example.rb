require_relative "../../../test_support/captures_stderr.rb"
require_relative "../../../test_support/captures_stdout.rb"

require_relative "temp_dir"

class Example

  include CapturesStderr
  include CapturesStdout

  attr_reader :stderr
  attr_reader :stdout

  def initialize(contents, opts = {})
    @contents = contents
    @filename = opts.fetch(:filename, "example.rb")
    @temp_dir = TempDir.new
    create_file
  end

  def run
    @stdout = capture_stdout do
      @stderr = capture_stderr do
        load path
      end
    end
  end

  private

  def create_file
    File.open(path, 'w') do |file|
      file.write @contents
    end
  end

  def path
    File.join(@temp_dir.path, @filename)
  end

end
