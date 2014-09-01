require_relative "spec_helper"

require "stringio"

require "print_debug"

# Test the library as the user uses it.  The other specs test
# internals.

describe PrintDebug do

  before(:each) do
    PrintDebug.configure { |c| c.reset }
  end

  describe "#q" do
    When(:stderr) do
      capture_stderr do
        q 123
      end
    end
    Then { stderr == "123\n" }
  end

  describe "#ql" do
    When(:stderr) do
      capture_stderr do
        @location = [File.basename(__FILE__), __LINE__ + 1].join(":")
        ql 123
      end
    end
    Then { stderr == "#{@location}: 123\n" }
  end

  describe "#tapq" do
    When do
      @stderr = capture_stderr do
        @result = ["1", "2"].map(&:to_i).tapq.inject(:+)
      end
    end
    Then { @result == 3}
    Then { @stderr == "[1, 2]\n" }
  end

  describe "#tapql" do
    When do
      @stderr = capture_stderr do
        @location = [File.basename(__FILE__), __LINE__ + 1].join(":")
        @result = ["1", "2"].map(&:to_i).tapql.inject(:+)
      end
    end
    Then { @result == 3}
    Then { @stderr == "#{@location}: [1, 2]\n" }
  end

  describe 'configure output' do
    Given(:io) { StringIO.new }
    Given do
      PrintDebug.configure do |c|
        c.out = io
      end
    end
    When do
      q 123
    end
    Then { io.string == "123\n" }
  end

end
