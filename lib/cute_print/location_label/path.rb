module CutePrint
  class LocationLabel
    # @api private
    class Path

      def initialize(location)
        @location = location
      end

      def to_s
        "%s:%d: " % [
          @location.path,
          @location.line_number,
        ]
      end

    end
  end
end
