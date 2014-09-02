require "forwardable"

module PrintDebug

  class Configure

    extend Forwardable

    # Configure an instance of printer.
    # @api private
    # @param [Printer] printer
    # @yield [Configure]
    def initialize(printer)
      @printer = printer
      yield self
    end

    def_delegator :@printer, :set_defaults, :reset

    def self.delegate_accessor(name)
      def_delegator :@printer, name
      def_delegator :@printer, "#{name}="
    end

    # @!attribute [rw] position_format
    #   @return [String] The position format
    #   @see Printer#position_format
    delegate_accessor :position_format

    # @!attribute [rw] out
    #   @return [#puts] The file to write to
    #   @see Printer#out
    delegate_accessor :out

  end

end
