require "stringio"

module CapturesStderr

  def capture_stderr
    orig_stderr = $stderr
    $stderr = StringIO.new
    begin
      yield
      $stderr.string
    ensure
      $stderr = orig_stderr
    end
  end

end

RSpec.configure do |c|
  c.include CapturesStderr
end
