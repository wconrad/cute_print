module CutePrint

  # @api private
  module FindsForeignCaller

    def nearest_foreign_caller
      caller.find do |s|
        path = s.split(":").first
        !File.expand_path(path).include?(File.expand_path(lib_path))
      end
    end

    def lib_path
      File.dirname(__FILE__)
    end

  end

end
