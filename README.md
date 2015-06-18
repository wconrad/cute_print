# cute_print
[![Gem Version](https://badge.fury.io/rb/cute_print.png)](http://badge.fury.io/rb/cute_print)
[![Dependency Status](https://gemnasium.com/wconrad/cute_print.svg)](https://gemnasium.com/wconrad/cute_print)
[![Build Status](https://travis-ci.org/wconrad/cute_print.png)](https://travis-ci.org/wconrad/cute_print)
[![Code Climate](https://codeclimate.com/github/wconrad/cute_print.png)](https://codeclimate.com/github/wconrad/cute_print)

Write debug output to stderr.  Optionally print the source filename
and line number, or the source of the debug statement.  Easily inspect
the middle of a call chain.

## Why?

* You want to print debug output very quickly, and remove it just as
  quickly.
* You want to easily label the debug output with the source
  location.
* You want to easily label the debug output with the debug
  code itself.
* You want to easily debug the middle of a call chain.
* You are debugging a program that is run with stdout redirected.

## Links

* This is a [rubygem](http://rubygems.org/gems/cute_print)
* The source is on [github](https://github.com/wconrad/cute_print)
* Cucumber-driven documentation is on
  [relishapp](https://www.relishapp.com/wconrad/cute-print/v/0-2-0/docs)
* API docs are at
  [rubydoc.info](http://rubydoc.info/gems/cute_print)

## Installation

Add this line to your application's Gemfile:

    gem "cute_print"

And then execute:

    $ bundle

Or install it yourself:

    $ gem install cute_print

## Usage

Start with:

    require "cute_print"

**q** work like
[Kernel#p](http://www.ruby-doc.org/core-2.1.3/Kernel.html#method-i-p),
except that it prints to $stderr instead of $stdout.

    q "abc"            # "abc"
    q [1, 2, 3 + 4]    # [1, 2, 7]

By passing a block, you can have the debug source printed along with
the value:

    i = 1
    q {i + 2}         # i + 2 is 3

**ql** will also print the source location:

    ql "abc"        # foo.rb:12: "abc"
    ql {1 + 2}      # foo.rb:13: 1 + 2 is 3

When called with no arguments, ql just prints the source location:

    ql              # foo.rb:14

This is very handy for answering "which branch did it take?," or "did
it even get to that method?"

**qq** pretty-prints its arguments to $stderr:

    a = (1..30).to_a
    qq a            # [1,
                    #  2,
                    #  ...
                    #  20,
                    #  30]

When called with a bock, qq prints the debug source as well:

    a = (1..30).to_a
    qq {a}          # a is [1,
                    #       2,
                    #       ...
                    #       20,
                    #       30]

**qql** also prints the source location:

    a = (1..30).to_a
    qq a            # foo.rb:12: [1,
                    #            2,
                    #            ...
                    #            20,
                    #            30]

When called with a block, qql prints the debug source as well:

    a = (1..30).to_a
    qq {a}          # foo.rb:12: a is [1,
                    #                  2,
                    #                  ...
                    #                  20,
                    #                  30]

**tapq** inspects the middle of a call chain:

    ["1", "2"].map(&:to_i).tapq.inject(&:+)
    # [1, 2]

**tapql** also prints the source location:

    ["1", "2"].map(&:to_i).tapql.inject(&:+)
    # bar.rb:12: [1, 2]

**tapqq** pretty-prints the middle of a call chain:

    a = (1..30).to_a
    sum = a.tapqq.inject(:+)    # [1,
                                # 2,
                                # ...
                                # 20,
                                # 30]

**tapqql** also prints the source location:

    a = (1..30).to_a
    sum = a.tapqq.inject(:+)    # foo.rb:12: [1,
                                #             2,
                                #             ...
                                #             20,
                                #             30]

## Configuration

To change the output device:

    CutePrint.configure do |c|
      c.out = File.open('/tmp/debug')
    end

Any object that responds to #print will do.

To cause #ql, #qql and #tapql to print the full path rather than just
the filename:

    CutePrint.configure do |c|
      c.location_format = :path
    end

The terminal width is detected, if possible, but you can override it:

    CutePrint.configure do |c|
      c.term_width = 132
    end

To set the terminal width back to being detected:

    CutePrint.configure do |c|
      c.term_width = :detect
    end

To reset the configuration to its defaults:

    CutePrint.configure do |c|
      c.reset
    end

## Without modifying Ruby classes

By default, this gem defines many methods on Object, making them
globally available.  To use this gem without any global methods,
require "cute_print/core" and then call one of the CutePrint class
methods:

    require "cute_print/core"
    CutePrint.q {1 + 2}        # 1 + 2 is 3

The "tap" methods are not available when using CutePrint this way.

## Rubies supported

This gem is known to work with these Rubies:

* ruby-1.9.3
* ruby-2.0
* ruby-2.1
* ruby-2.2

## Platforms supported

This gem is developed and tested with Linux.  It should work on
Windows and OSX as well.  If it does not work for you, please file an
issue on github.

## Other gems with similar functions

The [_wrong_][1] gem includes the excellent #d method, which is very
much like this gem's #q method.  This gem's ability to read the debug
statement's source is derived from the _wrong_ gem.

## Versioning

This gem uses [semantic versioning 2.0][3].

## Contributing

1. Fork it ( http://github.com/wconrad/cute_print/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: http://rubygems.org/gems/wrong
[2]: https://www.relishapp.com/wconrad/cute-print/v/0-2-0/docs
[3]: http://semver.org/spec/v2.0.0.html
