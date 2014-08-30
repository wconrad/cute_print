require_relative "spec_helper"

require "print_debug/printer"

module PrintDebug

  describe Printer do

    describe "#q" do

      context "single value" do
        Given(:out) { StringIO.new }
        Given(:printer) { Printer.new(:out => out) }
        When { printer.q [1, 2] }
        Then { out.string == "[1, 2]\n" }
      end

      context "multiple values" do
        Given(:out) { StringIO.new }
        Given(:printer) { Printer.new(:out => out) }
        When { printer.q 1, 2 }
        Then { out.string == "1\n2\n" }
      end

      context "arguments and closure" do
        Given(:out) { StringIO.new }
        Given(:printer) { Printer.new(:out => out) }
        When(:result) { printer.q("foo") {1 + 2} }
        Then { result == Failure(ArgumentError) }
      end

      context "closure (one line)" do
        Given(:out) { StringIO.new }
        Given(:printer) { Printer.new(:out => out) }
        When { printer.q {1 + 2} }
        Then { out.string == "(1 + 2) is 3\n" }
      end

      context "closure (two lines)" do
        Given(:out) { StringIO.new }
        Given(:printer) { Printer.new(:out => out) }
        When do
          printer.q do
            (1 + 2)
          end
        end
        Then { out.string == "(1 + 2) is 3\n" }
      end

    end

  end

end
