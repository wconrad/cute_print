require_relative "wraps_sexp"

module PrintDebug
  class RubyParser

    # @api private
    class Block
      include WrapsSexp
    end

  end
end
