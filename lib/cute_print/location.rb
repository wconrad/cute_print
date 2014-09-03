require_relative "finds_foreign_caller"

module CutePrint
  class Location

    extend FindsForeignCaller

    def self.find
      path, line_number = nearest_foreign_caller.split(':')
      line_number = line_number.to_i
      new(path, line_number)
    end

    def initialize(path, line_number)
      @path = path
      @line_number = line_number
    end

    def format(template)
      template % {
        path: @path,
        filename: filename,
        line_number: @line_number,
      }
    end

    private

    def filename
      File.basename(@path)
    end

  end
end
