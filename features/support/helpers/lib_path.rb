module LibPath

  def lib_path
    File.join(File.dirname(__FILE__), '../../../lib')
  end

end
