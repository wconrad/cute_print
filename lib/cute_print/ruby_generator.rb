require "ruby2ruby"

module CutePrint

  # @api private
  class RubyGenerator

    def self.to_ruby(sexp)
      sexp = sexp.deep_clone
      Ruby2Ruby.new.process(sexp)
    end

  end

end
