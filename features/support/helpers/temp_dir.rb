require "fileutils"
require "tmpdir"

require_relative "temp_dir"

class TempDir

  attr_reader :path

  def initialize
    @path = Dir.mktmpdir
    at_exit { FileUtils.remove_entry(@path) }
  end

end
