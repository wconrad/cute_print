require_relative "default_printer"
require_relative "printer"

module PrintDebug

  module Mixin

    # Don't use Forwardable to do this delegation: When finding the
    # call location, we look for the nearest call location that is not
    # in this library.  We must not stop at forwardable.
    def self.delegate_to_printer(method)
      define_method method do |*args, &block|
        PrintDebug::DefaultPrinter.printer.send(method, *args, &block)
      end
    end

    delegate_to_printer :q
    delegate_to_printer :ql

    def tapq
      q self
      self
    end

    def tapql
      ql self
      self
    end

  end
end
