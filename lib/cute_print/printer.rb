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

    # @see CutePrint.q
    def q(*values, &block)
      formatter = Formatter.new(
        method: __method__,
        out: @out,
        block: block,
        values: values
      )
      formatter.inspect
      formatter.write
      nil
    end

    # @see CutePrint.ql
    def ql(*values, &block)
      formatter = Formatter.new(
        method: __method__,
        out: @out,
        block: block,
        values: values)
      formatter.inspect
      formatter.with_location @location_format
      formatter.write
      nil
    end

    # @see CutePrint.qq
    def qq(*values, &block)
      formatter = Formatter.new(
        method: __method__,
        out: @out,
        block: block,
        values: values)
      formatter.pretty_print
      formatter.write
      nil
    end

    # @see CutePrint.qql
    def qql(*values, &block)
      formatter = Formatter.new(
        method: __method__,
        out: @out,
        block: block,
        values: values)
      formatter.pretty_print
      formatter.with_location @location_format
      formatter.write
      nil
    end

    private

  end
end
