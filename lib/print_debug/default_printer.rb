require_relative "printer"

module PrintDebug
  class DefaultPrinter

    def self.printer
      @printer ||= Printer.new
    end

  end
end
