# Ruby may implement #puts with two calls to #print: One for the
# value, and one for the new-line.  Do that, in order to flush
# out thread-safety bugs.

class ThreadUnsafeStringIO < StringIO
  def puts(*args)
    args.each do |arg|
      print arg
      Thread.pass
      print "\n"
    end
  end
end
