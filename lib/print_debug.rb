require_relative "print_debug/configure"
require_relative "print_debug/core_ext"
require_relative "print_debug/default_printer"

# Like Kernel#p, only fancier.  For example, this code:
#
#     require 'print_debug'
#     q { 1 + 2 }
#
# prints this to $stderr:
#
#     (1 + 2) is 3
module PrintDebug

  # Configure the library.  For example:
  #
  #     PrintDebug.configure do |c|
  #       c.out = $stdout
  #     end
  #
  # @yieldparam config [Configure]
  def self.configure(&block)
    Configure.new(DefaultPrinter.printer, &block)
  end

end
