require_relative "term_width/detect"
require_relative "term_width/static"

module CutePrint
  
  # @api private
  class TermWidth

    # Given a width, make an appropriate TermWidth object.  The object
    # returned has these readers:
    # * #width [Integer] Return the actual terminal width
    # * #visible [Object] Return the terminal width that
    #   #Configuration#term_width should return.
    # @param width [Object] Either the static terminal width,
    #   or :detect to automatically detect the terminal width.
    # @return [#width, #visible]
    def self.make(width)
      case width
      when Integer
        Static.new(width)
      when :detect
        Detect.new
      else
        raise ArgumentError, "Invalid terminal width: #{width.inspect}"
      end
    end

  end
end
