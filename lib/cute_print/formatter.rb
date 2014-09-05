require "pp"
require "stringio"

require_relative "location"
require_relative "ruby_parser"

module CutePrint
  # @api private
  class Formatter

    DEFAULT_WIDTH = 79
    DEFAULT_MAX_INLINE_LABEL_WIDTH = 40

    def initialize(opts = {})
      @inspector = :inspect
      @method = opts.fetch(:method)
      @out = opts.fetch(:out)
      @block = opts.fetch(:block, nil)
      @values = opts.fetch(:values, [])
      @width = opts.fetch(:width, DEFAULT_WIDTH)
      @max_inline_label_width = opts.fetch(:max_inline_label_width,
        DEFAULT_MAX_INLINE_LABEL_WIDTH)
      if @block && !@values.empty?
        raise ArgumentError, "arguments and block are mutually exclusive"
      end
      if !@block && @values.empty?
        raise ArgumentError, "either arguments or block must be given"
      end
    end

    def write
      labeled_values.each do |lines|
        write_lines lines
      end
    end

    def inspected_values
      values.map do |value|
        @inspector.call(value, value_width)
      end
    end

    def labeled_values
      if label_width > @max_inline_label_width
        outline_labeled_values
      else
        inline_labeled_values
      end
    end

    def inline_labeled_values
      labeled_values = inspected_values.map do |lines|
        lines.map.with_index do |line, i|
          if i == 0
            label + line
          else
            indent + line
          end
        end
      end
    end

    def outline_labeled_values
      inspected_values.map do |lines|
        [label.rstrip] + lines.map do |line|
          "  " + line
        end
      end
    end

    def with_location(location_format)
      @location_format = location_format
      @location = Location.find
    end

    def inspect
      @inspector = ->(value, value_width) do
        [value.inspect]
      end
    end

    def pretty_print
      @inspector = ->(value, value_width) do
        out = StringIO.new
        PP.pp(value, out, value_width)
        out.string.lines
      end
    end

    private

    def value_width
      @width - label_width
    end

    def values
      unless @values.empty?
        @values
      else
        [@block.call]
      end
    end

    def write_lines(lines)
      lines.each do |line|
        @out.puts line
      end
    end

    def label
      @label ||= make_label
    end

    def label_width
      label.size
    end

    def indent
      " " * label_width
    end

    def make_label
      [
        (@location.format(@location_format) if @location),
        ("#{block_code} is " if @block),
      ].compact.join
    end

    def block_code
      ruby_parser = RubyParser.from_block(@block)
      parsed_code = ruby_parser.parse
      method_call = parsed_code.first_call_to_method(@method)
      method_call.block.to_ruby
    end

  end
end
