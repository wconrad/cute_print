require_relative "../../../test_support/captures_stderr"
require_relative "../../../test_support/captures_stdout"
require_relative "lib_path"

require "open3"

# This example runner is relatively fast, but isn't available on all
# platforms.
class ForkExampleRunner

  include CapturesStderr
  include CapturesStdout
  include LibPath

  def self.supported?
    Process.respond_to?(:fork)
  end

  def run(path)
    stdout_rd, stdout_wr = IO.pipe
    stderr_rd, stderr_wr = IO.pipe
    pid = fork do
      $stdout.reopen stdout_wr
      $stderr.reopen stderr_wr
      load path
      exit! 0
    end
    Process.wait(pid)
    exit_status = $?
    stdout_wr.close
    stderr_wr.close
    stdout = stdout_rd.read
    stderr = stderr_rd.read
    yield stdout, stderr, exit_status
  end

end
