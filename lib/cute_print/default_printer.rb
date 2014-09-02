require_relative "printer"

module CutePrint

  # @api private
  class DefaultPrinter

    def self.printer
      @printer ||= Printer.new
    end

  end

end
