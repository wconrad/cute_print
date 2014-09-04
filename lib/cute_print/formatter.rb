require "pp"
require "stringio"

require_relative "ruby_parser"

module CutePrint
  # @api private
  class Formatter

    attr_accessor :block
    attr_accessor :location
    attr_accessor :location_format
    attr_accessor :values
    attr_accessor :inspector

    def initialize(opts = {})
      @inspector = :inspect
      @method = opts.fetch(:method)
      @out = opts.fetch(:out)
    end

    def write
      if @block && !@values.empty?
        raise ArgumentError, "arguments and block are mutually exclusive"
      end
      unless @block || @values
        raise ArgumentError, "either arguments or block must be given"
      end
      inspected_values = values.map do |value|
        inspector.call(value)
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

    private

    def inspector
      case @inspector
      when :inspect
        ->(value) do
          [value.inspect]
        end
      when :pretty_print
        ->(value) do
          out = StringIO.new
          PP.pp(value, out)
          out.string.lines
        end
      else
        raise ArgumentError, "Unknown inspector name: #{@inspector.inspect}"
      end
    end

    def values
      unless @values.empty?
        @values
      else
        [block.call]
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
