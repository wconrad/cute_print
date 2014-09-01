require_relative "finds_foreign_caller"
require_relative "ruby_parser"
require_relative "stderr_out"

module PrintDebug
  class Printer

    include FindsForeignCaller

    DEFAULT_POSITION_FORMAT = "%<filename>s:%<line_number>d: "

    # The object to write to.  Defaults to $stderr.
    # @return [#puts]
    attr_accessor :out

    # The position format.  To format a position, String#% is called
    # with a hash having these keys:
    #
    # * :path
    # * :filename
    # * :line_number
    #
    # The default format prints the filename and line number.
    # @see Printer::DEFAULT_POSITION_FORMAT
    # @return [String]
    attr_accessor :position_format

    # Create an instance.  If attributes are supplied, they override
    # the defaults.  For example:
    #
    #     PrintDebug.new(:out => $stdout)
    #
    # @api private
    def initialize(attrs = {})
      set_defaults
      attrs.each { |name, value| send "#{name}=", value }
    end

    # Set all attributes to their defaults.
    def set_defaults
      @out = StderrOut.new
      @position_format = DEFAULT_POSITION_FORMAT
    end

    # Inspect and write one or more objects.
    #
    # If called without a block, prints the inspected arguments, one
    # on a line.
    #
    # If called with a block, prints the source code of the block and
    # the inspected result of the block.
    def q(*values, &block)
      print(__method__, values, block) do |line|
        @out.puts line
      end
    end

    # Inspect and write one or more objects, with source position.
    #
    # If called without a block, prints the inspected arguments, one
    # on a line.
    #
    # If called with a block, prints the source code of the block and
    # the inspected result of the block.
    def ql(*values, &block)
      path, line_number = nearest_foreign_caller.split(":")
      line_number = line_number.to_i
      print(__method__, values, block) do |line|
        position = format_position(path, line_number)
        @out.puts "#{position}#{line}"
      end
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

    def format_position(path, line_number)
      position_values = {
        path: path,
        filename: File.basename(path),
        line_number: line_number,
      }
      @position_format % position_values
    end

  end
end
