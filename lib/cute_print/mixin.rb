require_relative "printer"

module CutePrint

  # Methods mixed into Object, and so available globally.
  #
  # @note The methods in this module are part of the public API, but
  #   the module itself is not.
  module Mixin

    # @see Printer#q
    def q(*args, &block)
      CutePrint.printer.q(*args, &block)
    end

    # @see Printer#ql
    def ql(*args, &block)
      CutePrint.printer.ql(*args, &block)
    end

    # @see Printer#qq
    def qq(*args, &block)
      CutePrint.printer.qq(*args, &block)
    end

    # @see Printer#qql
    def qql(*args, &block)
      CutePrint.printer.qql(*args, &block)
    end

    # Debug a call chain by printing self and then returning self.
    # @return [Object] self
    def tapq
      q self
      self
    end

    # Debug a call chain by printing self, with source location, and
    # then returning self.
    # @return [Object] self
    def tapql
      ql self
      self
    end

    # Debug a call chain by pretty-printing self and then returning
    # self.
    # @return [Object] self
    def tapqq
      qq self
      self
    end

    # Debug a call chain by pretty-printing self, with source
    # location, and then returning self.
    # @return [Object] self
    def tapqql
      qql self
      self
    end

  end
end
