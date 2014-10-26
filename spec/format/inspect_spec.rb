require_relative "../spec_helper"

require "cute_print/format/inspect"

module CutePrint
  module Format
    describe Inspect do

      let(:width) { 80 }
      let(:value) { (1..5).to_a }
      subject { Inspect.new.format(width, value) }
      specify do
        expect(subject).to eq [
          "[1, 2, 3, 4, 5]\n",
        ]
      end

    end
  end
end
