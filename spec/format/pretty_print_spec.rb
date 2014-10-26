require_relative "../spec_helper"

require "cute_print/format/pretty_print"

module CutePrint
  module Format
    describe PrettyPrint do

      let(:value) { (1..5).to_a }
      subject { PrettyPrint.new.format(width, value).to_a }

      context "fits on one line" do
        let(:width) { 80 }
        specify do
          expect(subject).to eq [
            "[1, 2, 3, 4, 5]\n",
          ]
        end
      end

      context "needs multiple lines" do
        let(:width) { 5 }
        specify do
          expect(subject).to eq [
            "[1,\n",
            " 2,\n",
            " 3,\n",
            " 4,\n",
            " 5]\n",
          ]
        end
      end

    end
  end
end
