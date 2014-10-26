module CutePrint
  # @api private
  class OutlineLabeler

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
      [labeled_first_line] + indented_remaining_lines
    end

    private

    def labeled_first_line
      @label + lines.first
    end

    def indented_remaining_lines
      indent = ' ' * @label.size
      lines[1..-1].map do |line|
        indent + line
      end
    end

    def lines
      @lines ||= @formatter.format(@width - @label.size, @value)
    end

  end
end
