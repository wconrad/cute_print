require "pp"
require "stringio"

require_relative "location"
require_relative "ruby_parser"

module CutePrint
  # @api private
  class Formatter

    def initialize(opts = {})
      @inspector = :inspect
      @method = opts.fetch(:method)
      @out = opts.fetch(:out)
      @block = opts.fetch(:block, nil)
      @values = opts.fetch(:values, [])
      if @block && !@values.empty?
        raise ArgumentError, "arguments and block are mutually exclusive"
      end
      if !@block && @values.empty?
        raise ArgumentError, "either arguments or block must be given"
      end
    end

    def write
      inspected_values = values.map do |value|
        @inspector.call(value)
      end
      labeled_values = inspected_values.map do |lines|
        lines.map.with_index do |line, i|
          if i == 0
            label + line
          else
            indent + line
          end
        end
      end
      labeled_values.each do |lines|
        write_lines lines
      end
    end

    def with_location(location_format)
      @location_format = location_format
      @location = Location.find
    end

    def inspect
      @inspector = ->(value) do
        [value.inspect]
      end
    end

    def pretty_print
      @inspector = ->(value) do
        out = StringIO.new
        PP.pp(value, out)
        out.string.lines
      end
    end

    private

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

    def indent
      " " * label.size
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
