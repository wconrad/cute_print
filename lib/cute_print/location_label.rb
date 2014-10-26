require_relative "location_label/filename"
require_relative "location_label/path"

module CutePrint
  # @api private
  class LocationLabel

    FORMATS = {
      filename: Filename,
      path: Path,
    }
    private_constant :FORMATS

    def self.make(format, location)
      klass = FORMATS[format]
      unless klass
        raise ArgumentError, "Unknown location format: #{format.inspect}"
      end
      klass.new(location)
    end

  end
end
