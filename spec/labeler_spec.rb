require_relative "spec_helper"

require "cute_print/labeler"

module CutePrint
  describe Labeler do

    WIDTH = 5
    WIDTHS = {
      fits: WIDTH,
      too_wide: WIDTH + 1,
      way_too_wide: WIDTH + 2,
    }

    def make_lines(opts)
      size = opts.fetch(:size)
      width = WIDTHS.fetch(opts.fetch(:width))
      line = ('x' * width) + "\n"
      Array.new(size, line)
    end

    let(:format) {double "format" }
    let(:label) { double "label" }
    let(:value) { double "value" }
    before(:each) do
      allow(OutlineLabeler)
        .to receive(:label)
        .with(format, WIDTH, label, value)
        .and_return(outlined_lines)
      allow(InlineLabeler)
        .to receive(:label)
        .with(format, WIDTH, label, value)
        .and_return(inlined_lines)
    end
    subject { Labeler.label(format, WIDTH, label, value) }

    context "the inline format fits on one line" do
      let(:outlined_lines) { make_lines(size: 1, width: :fits) }
      let(:inlined_lines) { double "inlined lines" }
      it "should return inline lines" do
        expect(subject).to equal outlined_lines
      end
      it "should not compute outlined lines" do
        expect(OutlineLabeler).to_not have_received(:label)
      end
    end

    context "both formats fit in the width; the inlined has fewer lines" do
      let(:outlined_lines) { make_lines(size: 3, width: :fits) }
      let(:inlined_lines) { make_lines(size: 2, width: :fits) }
      it "should return inlined lines" do
        expect(subject).to equal inlined_lines
      end
    end

    context "both formats fit in the width, are multiline, and have same size" do
      let(:outlined_lines) { make_lines(size: 2, width: :fits) }
      let(:inlined_lines) { make_lines(size: 2, width: :fits) }
      it "should return inline lines" do
        expect(subject).to equal outlined_lines
      end
    end

    context "inlined format fits in the width; inline format does not" do
      let(:outlined_lines) { make_lines(size: 2, width: :too_wide) }
      let(:inlined_lines) { make_lines(size: 2, width: :fits) }
      it "should return inlined lines" do
        expect(subject).to equal inlined_lines
      end
    end

    context "inlined format does not fits in the width; inline format does" do
      let(:outlined_lines) { make_lines(size: 2, width: :fits) }
      let(:inlined_lines) { make_lines(size: 2, width: :too_wide) }
      it "should return inline lines" do
        expect(subject).to equal outlined_lines
      end
    end

    context "neither format fits in the width; inlined is narrower" do
      let(:outlined_lines) { make_lines(size: 2, width: :way_too_wide) }
      let(:inlined_lines) { make_lines(size: 2, width: :too_wide) }
      it "should return inlined lines" do
        expect(subject).to equal inlined_lines
      end
    end

    context "neither format fits in width; are same width; inlined is shorter" do
      let(:outlined_lines) { make_lines(size: 3, width: :too_wide) }
      let(:inlined_lines) { make_lines(size: 2, width: :too_wide) }
      it "should return inlined lines" do
        expect(subject).to equal inlined_lines
      end
    end

  end
end
