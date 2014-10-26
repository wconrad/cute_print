module CutePrint
  module Format
    # @api private
    class Inspect

      def format(width, value)
        [value.inspect + "\n"]
      end

    end
  end
end
