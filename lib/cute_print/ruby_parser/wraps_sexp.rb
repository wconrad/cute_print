require_relative "../ruby_generator"

module CutePrint
  class RubyParser

    # @api private
    module WrapsSexp

      def initialize(sexp)
        @sexp = sexp
      end

      def to_ruby
        RubyGenerator.to_ruby(@sexp)
      end

    end
  end
end
