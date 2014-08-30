require_relative "print_debug/configure"
require_relative "print_debug/core_ext"
require_relative "print_debug/default_printer"

module PrintDebug

  def self.configure(&block)
    Configure.new(DefaultPrinter.printer, &block)
  end

end
