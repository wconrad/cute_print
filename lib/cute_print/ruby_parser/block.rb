require_relative "wraps_sexp"

module CutePrint
  class RubyParser

    # @api private
    class Block
      include WrapsSexp
    end

  end
end
