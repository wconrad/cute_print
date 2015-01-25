require_relative "formatter"
require_relative "stderr_out"
require_relative "term_width"

module CutePrint
  class Printer

    include FindsForeignCaller

    # The object to write to.  Defaults to $stderr.
    # @return [#print]
    attr_accessor :out

    # The location format.  Defaults to :filename
    #
    # One of:
    # * :filename
    # * :path
    #
    # @return [String]
    attr_accessor :location_format

    # The terminal width.  May be an integer, or :detect to cause the
    # terminal width to be determined automatically.  Defaults to
    # :detect
    #
    # @!attribute [rw] term_width
    #   @return [Integer, Symbol]

    def term_width
      @term_width.visible
    end

    def term_width=(value)
      @term_width = TermWidth.make(value)
    end

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
      self.term_width = :detect
    end

    # @see CutePrint.q
    def q(*values, &block)
      formatter = make_formatter(__method__, values, block)
      formatter.inspect
      formatter.write
      nil
    end

    # @see CutePrint.ql
    def ql(*values, &block)
      formatter = make_formatter(__method__, values, block)
      formatter.inspect
      formatter.with_location @location_format
      formatter.write
      nil
    end

    # @see CutePrint.qq
    def qq(*values, &block)
      formatter = make_formatter(__method__, values, block)
      formatter.pretty_print
      formatter.write
      nil
    end

    # @see CutePrint.qql
    def qql(*values, &block)
      formatter = make_formatter(__method__, values, block)
      formatter.pretty_print
      formatter.with_location @location_format
      formatter.write
      nil
    end

    private

    def make_formatter(method, values, block)
      Formatter.new(
        method: method,
        block: block,
        values: values,
        out: @out,
        width: @term_width.width)
    end

  end
end
