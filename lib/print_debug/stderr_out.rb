module PrintDebug

  # Writing to an instance of this class, rather than directly to
  # $stderr, allows the tests to capture output by assigning to
  # $stderr.
  class StderrOut

    def puts(*args)
      $stderr.puts(*args)
    end

  end
end
