require "forwardable"

module PrintDebug

  class Configure

    extend Forwardable

    def initialize(printer)
      @printer = printer
      yield self
    end

    def_delegators :@printer,
    :out=

  end

end
