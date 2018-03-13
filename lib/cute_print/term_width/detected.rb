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
        width, _height = detect_terminal_size
        # Hirb returns nil if it can't determine the terminal width.
        # Program run in Emacs have an apparent terminal width of "0".
        width = FALLBACK_WIDTH if width.nil? || width == 0
        width
      end

      def width_override_for_tests
        n = ENV['CUTE_PRINT_TERM_WIDTH']
        n && Integer(n)
      end

      # This function extracted from hirb version 0.7.3.  hirb is
      # copyright (c) 2010 by Gabriel Horner and licensed under the
      # MIT License.  This gem also uses the MIT License, so there is
      # no problem with moving that function into here.
      #
      # The project: https://github.com/cldwalker/hirb
      # The specific file:
      # https://github.com/cldwalker/hirb/blob/master/lib/hirb/util.rb#L59
      #
      # We extracted the function because hirb is no longer maintained
      # and now causes warnings with ruby-2.4.0 or greater.

      # Returns [width, height] of terminal when detected, nil if not detected.
      # Think of this as a simpler version of Highline's Highline::SystemExtensions.terminal_size()
      def detect_terminal_size
        if (ENV['COLUMNS'] =~ /^\d+$/) && (ENV['LINES'] =~ /^\d+$/)
          [ENV['COLUMNS'].to_i, ENV['LINES'].to_i]
        elsif (RUBY_PLATFORM =~ /java/ || (!STDIN.tty? && ENV['TERM'])) && command_exists?('tput')
          [`tput cols`.to_i, `tput lines`.to_i]
        elsif STDIN.tty? && command_exists?('stty')
          `stty size`.scan(/\d+/).map { |s| s.to_i }.reverse
        else
          nil
        end
      rescue
        nil
      end

    end

  end
end
