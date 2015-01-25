require "hirb"

module CutePrint
  class TermWidth

    # A terminal width that tries to determine the terminal width
    # automatically.
    # @api private
    class Detected

      attr_reader :width

      def initialize
        @width = detect_width
      end

      def visible
        :detect
      end

      private

      FALLBACK_WIDTH = 79

      def detect_width
        return width_override_for_tests if width_override_for_tests
        width, _height = Hirb::Util.detect_terminal_size
        # Program run in Emacs have an apparent terminal width of "0".
        width = FALLBACK_WIDTH if width == 0
        width
      end

      def width_override_for_tests
        n = ENV['CUTE_PRINT_TERM_WIDTH']
        n && Integer(n)
      end

    end

  end
end
