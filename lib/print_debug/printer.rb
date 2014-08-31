require_relative "finds_foreign_caller"
require_relative "ruby_parser"
require_relative "stderr_out"

module PrintDebug
  class Printer

    include FindsForeignCaller

    attr_accessor :out

    def initialize(attrs = {})
      set_defaults
      attrs.each { |name, value| send "#{name}=", value }
    end

    def q(*values, &block)
      print(__method__, values, block) do |line|
        @out.puts line
      end
    end

    def ql(*values, &block)
      path, line_number = nearest_foreign_caller.split(":")
      filename = File.basename(path)
      line_number = line_number.to_i
      print(__method__, values, block) do |line|
        @out.puts "%s:%d: %s" % [
          filename, line_number, line
        ]
      end
    end

    def set_defaults
      @out = StderrOut.new
    end

    private

    def print(method, values, block)
      if block && !values.empty?
        raise ArgumentError, "arguments and block are mutually exclusive"
      end
      if block
        ruby_parser = RubyParser.from_block(block)
        parsed_code = ruby_parser.parse
        method_call = parsed_code.first_call_to_method(method)
        block_code = method_call.block.to_ruby
        yield "%s is %s" % [
          block_code,
          block.call.inspect,
        ]
      else
        values.each do |value|
          yield value.inspect
        end
      end
    end

  end
end
