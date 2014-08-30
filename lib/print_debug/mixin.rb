require "forwardable"

require_relative "default_printer"
require_relative "printer"

module PrintDebug

  module Mixin

    extend Forwardable

    def_delegators 'PrintDebug::DefaultPrinter.printer',
    :q

  end
end
