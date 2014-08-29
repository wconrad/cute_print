require_relative "method_call"
require_relative "wraps_sexp"

module PrintDebug
  class RubyParser

    # How this class works is stolen this excellent code:
    # https://github.com/sconover/wrong/blob/30475fc5ac9d0f73135d229b1b44c045156a7e7a/lib/wrong/d.rb

    class ParsedCode

      include WrapsSexp

      def first_call_to_method(method_name)
        @sexp.deep_each do |node|
          if MethodCall.call_to_method?(node, method_name)
            return MethodCall.new(node)
          end
        end
        raise "Method call not found"
      end

    end
  end
end
