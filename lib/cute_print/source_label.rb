require_relative "ruby_parser"

module CutePrint
  # @api private
  class SourceLabel

    def initialize(block, method)
      @block = block
      @method = method
    end

    def to_s
      "#{block_code} is "
    end

    private

    def block_code
      ruby_parser = RubyParser.from_block(@block)
      parsed_code = ruby_parser.parse
      method_call = parsed_code.first_call_to_method(@method)
      method_call.block.to_ruby
    end

  end
end
