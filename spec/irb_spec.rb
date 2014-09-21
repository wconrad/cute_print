require_relative "spec_helper"

require "irb"
require "open3"
require "stringio"

require "cute_print"

describe CutePrint do

  it "should be able to inspect source when called from irb" do
    lib_path = File.join(File.dirname(__FILE__), "../lib/cute_print")
    stdout, stderr = Open3.popen3("irb") do |stdin, stdout, stderr, wait_thr|
      stdin.puts "require #{lib_path.inspect}"
      stdin.puts "q {1 + 2}"
      stdin.close
      [stdout.read, stderr.read]
    end
    expect(stderr).to eq "(1 + 2) is 3\n"
  end

end
