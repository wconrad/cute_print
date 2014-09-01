require "forwardable"

module PrintDebug

  class Configure

    extend Forwardable

    def initialize(printer)
      @printer = printer
      yield self
    end

    def_delegator :@printer, :set_defaults, :reset

    def self.delegate_accessor(name)
      def_delegator :@printer, name
      def_delegator :@printer, "#{name}="
    end

    delegate_accessor :position_format
    delegate_accessor :out

  end

end
