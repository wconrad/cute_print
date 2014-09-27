require_relative "spec_helper"

require "stringio"

require "cute_print"

# This spec tests the parts of the library, as the user sees it, that
# are not covered by a Cucumber feature.
#
# The other specs test internals.

describe CutePrint do

  before(:each) do
    CutePrint.configure { |c| c.reset }
  end

  describe "#q" do
    When(:stderr) do
      capture_stderr do
        @result = q 123
      end
    end
    Then { expect(@result).to be_nil }
  end

  describe "#ql" do
    When(:stderr) do
      capture_stderr do
        @result = ql 123
      end
    end
    Then { expect(@result).to be_nil }
  end

  describe "#qq" do
    When do
      @stderr = capture_stderr do
        @result = qq 123
      end
    end
    Then { expect(@result).to be_nil }
  end

  describe "#qql" do
    When do
      @stderr = capture_stderr do
        @result = qql 123
      end
    end
    Then { expect(@result).to be_nil }
  end

end
