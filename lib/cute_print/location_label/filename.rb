module CutePrint
  class LocationLabel
    # @api private
    class Filename

      def initialize(location)
        @location = location
      end

      def to_s
        "%s:%d: " % [
          @location.filename,
          @location.line_number,
        ]
      end

    end
  end
end
