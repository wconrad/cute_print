# -*- coding: utf-8 -*-
# From [Ruby verbose mode and how it's broken][1] by Mislav Marohnić
# [1]: http://mislav.uniqpath.com/2011/06/ruby-verbose-mode/
#
# Silence Ruby verbose output.  Use this to quiet warnings from
# a third-party library:
#
#     silence_warnings do
#       require "library_with_many_warnings"
#     end
module Kernel

  def silence_warnings
    with_warnings(nil) { yield }
  end

  def with_warnings(flag)
    old_verbose, $VERBOSE = $VERBOSE, flag
    yield
  ensure
    $VERBOSE = old_verbose
  end

end unless Kernel.respond_to? :silence_warnings
