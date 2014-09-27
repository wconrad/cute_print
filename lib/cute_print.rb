require_relative "cute_print/configure"
require_relative "cute_print/core_ext"

# Like Kernel#p, only fancier.  For example, this code:
#
#     require 'cute_print'
#     q { 1 + 2 }
#
# prints this to $stderr:
#
#     (1 + 2) is 3
module CutePrint

  # Configure the library.  For example:
  #
  #     CutePrint.configure do |c|
  #       c.out = $stdout
  #     end
  #
  # @yieldparam config [Configure]
  def self.configure(&block)
    Configure.new(printer, &block)
  end

  # @return [Printer] the singleton printer
  # @api private
  def self.printer
    @printer ||= Printer.new
  end

end
