require "stringio"

module CapturesStdout

  def capture_stdout
    orig_stdout = $stdout
    $stdout = StringIO.new
    begin
      yield
      $stdout.string
    ensure
      $stdout = orig_stdout
    end
  end

end
