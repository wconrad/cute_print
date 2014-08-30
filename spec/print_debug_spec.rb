require_relative "spec_helper"

require "stringio"

require "print_debug"

describe PrintDebug do

  describe "#q" do
    When(:stderr) do
      capture_stderr do
        q 123
      end
    end
    Then { stderr == "123\n" }
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
