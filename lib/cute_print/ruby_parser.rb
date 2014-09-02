require "ruby_parser"

require_relative "ruby_parser/parsed_code"

module CutePrint

  # This class is very much cribbed from this excellent code:
  #
  #     https://github.com/sconover/wrong/blob/30475fc5ac9d0f73135d229b1b44c045156a7e7a/lib/wrong/chunk.rb
  #
  # @api private

  class RubyParser

    def self.from_block(block)
      path, line_number = block.to_proc.source_location
      new(path, line_number, &block)
    end

    def initialize(path, line_number, &block)
      @path = path
      @line_number = line_number
      @block = block
    end

    def parse
      @parsed ||= parse_source(read_source)
    end

    private

    def read_source
      File.read(@path)
    end

    def parser
      @parser ||= ::RubyParser.new
    end

    # Try parsing just the starting line.  While that doesn't work,
    # add another line and try again.
    def parse_source(source)
      lines = source.lines.to_a
      starting_line_index = @line_number - 1
      ending_line_index = starting_line_index
      sexp = nil
      while !sexp && ending_line_index < lines.size
        begin
          snippet = lines.to_a[starting_line_index..ending_line_index].join
          sexp = parser.parse(snippet)
          return ParsedCode.new(sexp)
        rescue Racc::ParseError
          ending_line_index += 1
          raise if ending_line_index >= lines.size
        end
      end
    end

  end
end
