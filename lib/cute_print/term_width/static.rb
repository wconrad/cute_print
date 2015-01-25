module CutePrint
  class TermWidth

    # A terminal width with a fixed value
    # @api private
    class Static

      attr_reader :width

      def initialize(width)
        @width = width
      end

      def visible
        @width
      end

    end

  end
end
