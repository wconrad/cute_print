require_relative "block"
require_relative "wraps_sexp"

module CutePrint
  class RubyParser

    # @api private
    class MethodCall

      include WrapsSexp

      def self.call_to_method?(sexp, method_name)
        call?(sexp) && sexp[1][2] == method_name
      end

      def self.call?(sexp)
        sexp[0] == :iter && sexp[1][0] == :call
      end

      def block
        Block.new(@sexp[3])
      end

    end

  end
end
