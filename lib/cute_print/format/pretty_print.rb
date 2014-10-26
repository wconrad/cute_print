require 'pp'
require 'stringio'

module CutePrint
  module Format
    # @api private
    class PrettyPrint

      def format(width, value)
        out = StringIO.new
        PP.pp(value, out, width)
        out.string.lines
      end

    end
  end
end
