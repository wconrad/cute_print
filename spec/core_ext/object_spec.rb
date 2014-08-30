require_relative "../spec_helper"

require "stringio"

require "print_debug/core_ext/object"

describe Object do

  describe "#q" do
    When(:stderr) do
      capture_stderr do
        q 123
      end
    end
    Then { stderr == "123\n" }
  end

end
