require_relative "../ruby_generator"

module PrintDebug
  class RubyParser

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
