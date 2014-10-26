require_relative "inline_labeler"
require_relative "outline_labeler"

module CutePrint
  # @api private
  class Labeler

    def self.label(format, width, label, value)
      new(format, width, label, value).labeled
    end

    def initialize(format, width, label, value)
      @format = format
      @width = width
      @label = label
      @value = value
    end

    def labeled
      # Optimization: Avoid the computation of "outlined", and the
      # elaborate comparison, in many cases.
      return outlined if outlined_fits_on_one_line?
      inlined_fits = lines_fit_horizontally?(inlined)
      outlined_fits = lines_fit_horizontally?(outlined)
      if inlined_fits && outlined_fits
        [inlined, outlined].min_by do |lines|
          [
            lines.size,
            lines.equal?(outlined) ? 0 : 1,
          ]
        end
      elsif inlined_fits && !outlined_fits
        inlined
      elsif !inlined_fits && outlined_fits
        outlined
      else # neither fits
        [inlined, outlined].min_by do |lines|
          [
            lines.map(&:size).min,
            lines.size,
          ]
        end
      end
    end

    private

    def lines_fit_horizontally?(lines)
      lines.all? do |line|
        line_fits_horizontally?(line)
      end
    end

    def line_fits_horizontally?(line)
      line.chomp.size <= @width
    end

    def outlined_fits_on_one_line?
      outlined.size == 1 && line_fits_horizontally?(outlined.first)
    end

    def outlined
      @outlined ||= OutlineLabeler.label(@format, @width, @label, @value)
    end

    def inlined
      @inlined ||= InlineLabeler.label(@format, @width, @label, @value)
    end
    
  end
end
