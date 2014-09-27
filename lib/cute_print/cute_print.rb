require_relative "configure"
require_relative "printer"

# Like Kernel#p, only fancier.  For example, this code:
#
#     require "cute_print"
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

  # Inspect and write one or more objects.
  #
  # If called without a block, prints the inspected arguments, one
  # on a line.
  #
  # If called with a block, prints the source code of the block and
  # the inspected result of the block.
  #
  # @return nil
  def self.q(*args, &block)
    printer.q(*args, &block)
  end

  # Inspect and write one or more objects, with source location.
  #
  # If called without a block, prints the inspected arguments, one
  # on a line.
  #
  # If called with a block, prints the source code of the block and
  # the inspected result of the block.
  #
  # @return nil
  def self.ql(*args, &block)
    printer.ql(*args, &block)
  end

  # Pretty-print and write one or more objects.
  #
  # If called without a block, pretty-prints the pretty-printed
  # arguments, one on a line.
  #
  # If called with a block, prints the source code of the block and
  # pretty-prints the result of the block.
  #
  # @return nil
  def self.qq(*args, &block)
    printer.qq(*args, &block)
  end

  # Pretty-print and write one or more objects, with source location.
  #
  # If called without a block, pretty-prints the arguments, one on a
  # line.
  #
  # If called with a block, prints the source code of the block and
  # pretty-prints the result of the block.
  #
  # @return nil
  def self.qql(*args, &block)
    printer.qql(*args, &block)
  end

end
