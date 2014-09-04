require_relative "formatter"
require_relative "location"
require_relative "stderr_out"

module CutePrint
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
    #     CutePrint.new(:out => $stdout)
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
      formatter = Formatter.new(method: __method__, out: @out)
      formatter.block = block
      formatter.values = values
      formatter.inspector = :inspect
      formatter.write
    end

    # Inspect and write one or more objects, with source position.
    #
    # If called without a block, prints the inspected arguments, one
    # on a line.
    #
    # If called with a block, prints the source code of the block and
    # the inspected result of the block.
    def ql(*values, &block)
      location = Location.find
      formatter = Formatter.new(method: __method__, out: @out)
      formatter.block = block
      formatter.values = values
      formatter.inspector = :inspect
      formatter.location = Location.find
      formatter.location_format = @position_format
      formatter.write
    end

    # Pretty-print and write one or more objects.
    #
    # If called without a block, pretty-prints the pretty-printed
    # arguments, one on a line.
    #
    # If called with a block, prints the source code of the block and
    # pretty-prints the result of the block.
    def qq(*values, &block)
      formatter = Formatter.new(method: __method__, out: @out)
      formatter.block = block
      formatter.values = values
      formatter.inspector = :pretty_print
      formatter.write
    end

    # Pretty-print and write one or more objects, with source position.
    #
    # If called without a block, pretty-prints the pretty-printed
    # arguments, one on a line.
    #
    # If called with a block, prints the source code of the block and
    # pretty-prints the result of the block.
    def qql(*values, &block)
      formatter = Formatter.new(method: __method__, out: @out)
      formatter.block = block
      formatter.values = values
      formatter.inspector = :pretty_print
      formatter.location = Location.find
      formatter.location_format = @position_format
      formatter.write
    end

    private

  end
end
