require_relative "printer"

module PrintDebug

  # @api private
  class DefaultPrinter

    def self.printer
      @printer ||= Printer.new
    end

  end

end
