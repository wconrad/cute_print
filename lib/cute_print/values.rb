require "forwardable"

module CutePrint

  # @api private
  class Values

    extend Forwardable
    include Enumerable

    def initialize(args, block)
      if !args.empty? && block
        raise ArgumentError, "arguments and block are mutually exclusive"
      end
      @args = args
      @block = block
    end

    def_delegator :values, :each
    def_delegator :values, :empty?

    private

    def values
      if @block
        [@block.call]
      else
        @args
      end
    end

  end

end
