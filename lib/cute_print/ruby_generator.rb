require "ruby2ruby"

require_relative "ruby_generator"

module CutePrint

  # @api private
  class RubyGenerator

    def self.to_ruby(sexp)
      sexp = sexp.deep_clone
      Ruby2Ruby.new.process(sexp)
    end

  end

end
