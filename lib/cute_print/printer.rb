require_relative "formatter"
require_relative "stderr_out"

module CutePrint
  class Printer

    include FindsForeignCaller

    # The object to write to.  Defaults to $stderr.
    # @return [#print]
    attr_accessor :out

    # The location format.
    #
    # One of:
    # * :filename
    # * :path
    #
    # @return [String]
    attr_accessor :location_format

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
      @location_format = :filename
    end

    # Inspect and write one or more objects.
    #
    # If called without a block, prints the inspected arguments, one
    # on a line.
    #
    # If called with a block, prints the source code of the block and
    # the inspected result of the block.
    def q(*values, &block)
      formatter = Formatter.new(
        method: __method__,
        out: @out,
        block: block,
        values: values
      )
      formatter.inspect
      formatter.write
    end

    # Inspect and write one or more objects, with source location.
    #
    # If called without a block, prints the inspected arguments, one
    # on a line.
    #
    # If called with a block, prints the source code of the block and
    # the inspected result of the block.
    def ql(*values, &block)
      formatter = Formatter.new(
        method: __method__,
        out: @out,
        block: block,
        values: values)
      formatter.inspect
      formatter.with_location @location_format
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
      formatter = Formatter.new(
        method: __method__,
        out: @out,
        block: block,
        values: values)
      formatter.pretty_print
      formatter.write
    end

    # Pretty-print and write one or more objects, with source location.
    #
    # If called without a block, pretty-prints the arguments, one on a
    # line.
    #
    # If called with a block, prints the source code of the block and
    # pretty-prints the result of the block.
    def qql(*values, &block)
      formatter = Formatter.new(
        method: __method__,
        out: @out,
        block: block,
        values: values)
      formatter.pretty_print
      formatter.with_location @location_format
      formatter.write
    end

    private

  end
end
