require "pp"
require "stringio"

require_relative "format"
require_relative "labeler"
require_relative "location"
require_relative "location_label"
require_relative "source_label"
require_relative "values"

module CutePrint
  # @api private
  class Formatter

    def initialize(opts = {})
      @method = opts.fetch(:method)
      @out = opts.fetch(:out)
      @block = opts.fetch(:block, nil)
      @args = opts.fetch(:values, [])
      @values = Values.new(@args, @block)
      @width = opts.fetch(:width)
      @location_label = nil
    end

    def write
      if @values.empty? && !label.empty?
        write_line label.chomp(": ")
      else
        @values.each do |value|
          labeler = Labeler.new(@format, @width, label, value)
          write_lines labeler.labeled
        end
      end
    end

    def with_location(format_key)
      location = Location.find
      @location_label = LocationLabel.make(format_key, location)
    end

    def inspect
      @format = Format::Inspect.new
    end

    def pretty_print
      @format = Format::PrettyPrint.new
    end

    private

    def write_lines(lines)
      lines.each do |line|
        write_line line
      end
    end

    def write_line(line)
      line += "\n" unless line =~ /\n\Z/
      @out.print line
    end

    def label
      @label ||= make_label
    end

    def make_label
      [
        (@location_label.to_s if @location_label),
        (SourceLabel.new(@block, @method) if @block),
      ].compact.join
    end

  end
end
