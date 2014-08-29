require 'pp' #DEBUG

require_relative "ruby_parser"

module PrintDebug
  class Printer

    def initialize(opts = {})
      @out = opts.fetch(:out) { $stderr }
    end

    def q(*values, &block)
      if block && !values.empty?
        raise ArgumentError, "arguments and block are mutually exclusive"
      end
      if block_given?
        ruby_parser = RubyParser.from_block(block)
        parsed_code = ruby_parser.parse
        method_call = parsed_code.first_call_to_method(__method__)
        block_code = method_call.block.to_ruby
        @out.puts "%s is %s" % [
          block_code,
          block.call.inspect,
        ]
      else
        values.each do |value|
          @out.puts value.inspect
        end
      end
    end

  end
end
