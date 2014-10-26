require_relative "spec_helper"

require "cute_print/outline_labeler"

module CutePrint
  describe OutlineLabeler do

    let(:label) { "foo.rb:1: " }
    let(:value) { [1, 2, 3, 4, 5] }
    subject { OutlineLabeler.label(formatter, width, label, value) }

    context "single line" do
      let(:formatter) { Format::Inspect.new }
      let(:width) { 80 }
      specify do
        expect(subject).to eq [
          "foo.rb:1: [1, 2, 3, 4, 5]\n",
        ]
      end
    end

    context "multiple lines" do
      let(:formatter) { Format::PrettyPrint.new }
      let(:width) { 4 }
      specify do
        expect(subject).to eq [
          "foo.rb:1: [1,\n",
          "           2,\n",
          "           3,\n",
          "           4,\n",
          "           5]\n",
        ]
      end
    end

  end
end
