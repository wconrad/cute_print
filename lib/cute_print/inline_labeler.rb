module CutePrint
  # @api private
  class InlineLabeler

    def self.label(formatter, width, label, value)
      new(formatter, width, label, value).labeled
    end

    def initialize(formatter, width, label, value)
      @formatter = formatter
      @width = width
      @label = label
      @value = value
    end

    def labeled
      [@label.rstrip + "\n"] + indented_lines
    end

    private

    INDENT = '  '
    private_constant :INDENT

    def indented_lines
      lines.map do |line|
        INDENT + line
      end
    end

    def lines
      @formatter.format(@width - INDENT.size, @value)
    end

  end
end
