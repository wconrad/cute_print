require 'forwardable'

module CutePrint

  # Writing to an instance of this class, rather than to an instance
  # variable that was set to $stderr, allows the tests to capture
  # output by assigning to $stderr.
  # @api private
  class StderrOut

    extend Forwardable

    def_delegators :$stderr,
    :puts,
    :print

  end
end
