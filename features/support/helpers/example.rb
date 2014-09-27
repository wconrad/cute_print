require_relative "example_runner"
require_relative "temp_dir"

class Example

  def initialize(contents, opts = {})
    @contents = contents
    @filename = opts.fetch(:filename, "example.rb")
    @temp_dir = TempDir.new
    create_file
  end

  def run
    ExampleRunner.run(path) do |stdout, stderr, exit_status|
      @stdout = stdout
      @stderr = stderr
      @exit_status = exit_status
      if @exit_status != 0
        fail "Failed: #{@stdout}\n#{@stderr}"
      end
    end
  end

  def stdout
    filter_output(@stdout)
  end

  def stderr
    filter_output(@stderr)
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

  def filter_output(output)
    redact_tmp_path(output)
  end

  def redact_tmp_path(output)
    output.sub(/\/tmp\/.*\//, "/tmp/.../")
  end

end
