require "forwardable"

module PrintDebug

  class Configure

    extend Forwardable

    def initialize(printer)
      @printer = printer
      yield self
    end

    def self.reset
      DefaultPrinter.printer.set_defaults
    end

    def_delegators :@printer,
    :out=

  end

end
