require_relative "default_printer"
require_relative "printer"

module PrintDebug

  # Methods mixed into Object, and so available globally.
  #
  # @note The methods in this module are part of the public API, but
  #   the module itself is not.

  module Mixin

    # @see Printer#q
    def q(*args, &block)
      PrintDebug::DefaultPrinter.printer.q(*args, &block)
    end

    # @see Printer#ql
    def ql(*args, &block)
      PrintDebug::DefaultPrinter.printer.ql(*args, &block)
    end

    # Debug a call chain by printing self and then returning self.
    # @return [Object] self
    def tapq
      q self
      self
    end

    # Debug a call chain by printing self, with source position, and
    # then returning self.
    # @return [Object] self
    def tapql
      ql self
      self
    end

  end
end
