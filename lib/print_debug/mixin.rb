require "forwardable"

require_relative "printer"

module PrintDebug
  module Mixin

    extend Forwardable

    def print_debug_printer
      @print_debug_printer ||= Printer.new
    end

    def_delegators :print_debug_printer,
    :q

  end
end
