require_relative "ruby_parser"

module CutePrint
  class Formatter

    attr_accessor :block
    attr_accessor :location
    attr_accessor :location_format
    attr_accessor :values

    def initialize(opts = {})
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
      lines = values.map(&:inspect)
      lines.map! do |value|
        label + value
      end
      write_lines lines
    end

    private

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
