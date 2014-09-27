require "open3"

require_relative "lib_path"

# This example runner is relatively slow, but should work on platforms
# which do not support fork, such as Windows.
class ShellExampleRunner

  include LibPath

  def run(path)
    command = [
      "ruby",
      "-I", lib_path,
      path,
    ]
    Open3.popen3(*command) do |stdin, stdout, stderr, wait_thr|
      stdin.close
      stdout = stdout.read
      stderr = stderr.read
      exit_status = wait_thr.value
      yield stdout, stderr, exit_status
    end
  end

end
