require_relative "../../../test_support/captures_stderr.rb"

require_relative "temp_dir"

class Example

  include CapturesStderr

  attr_reader :stderr

  def initialize(contents, opts = {})
    @contents = contents
    @filename = opts.fetch(:filename, "example.rb")
    @temp_dir = TempDir.new
    create_file
  end

  def run
    @stderr = capture_stderr do
      load path
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
