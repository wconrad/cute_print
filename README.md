# cute_print
[![Gem Version](https://badge.fury.io/rb/cute_print.png)](http://badge.fury.io/rb/cute_print)
[![Dependency Status](https://gemnasium.com/wconrad/cute_print.svg)](https://gemnasium.com/wconrad/cute_print)
[![Build Status](https://travis-ci.org/wconrad/cute_print.png)](https://travis-ci.org/wconrad/cute_print)
[![Code Climate](https://codeclimate.com/github/wconrad/cute_print.png)](https://codeclimate.com/github/wconrad/cute_print)

Write debug output to stderr.  Optionally print the source filename
and line number, or the source of the debug statement.  Easily debug
the middle of a call chain.

## Features

* Inspects its output, like Kernel#p.
* Writes to $stderr by default (good when $stdout is redirected).
* Can print the filename and line number.
* Can print the source of the value.
* Can print a value in the middle of a call chain.
* Configurable output device.

This is for those who prefer to debug by writing things to the
console.

## Installation

Add this line to your application's Gemfile:

    gem "cute_print"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cute_print

## Usage

Start with:

    require "cute_print"

You can use q just like you use Kernel#p.  It will work the same,
except that its output goes to $stderr instead of $stdout:

    q "abc"            # "abc"
    q [1, 2, 3 + 4]    # [1, 2, 7]

You can have the debug source printed along with the value:

    i = 1
    q {i + 2}         # i + 2 is 3

Kernel#ql will add the source location:

    ql "abc"        # foo.rb:12: "abc"
    ql {1 + 2}      # foo.rb:13: 1 + 2 is 3

Call chains can be a pain to debug, but it's easy with Kernel#tapq and
Kernel#tapql:

    ["1", "2"].map(&:to_i).tapq.inject(&:+)
    # [1, 2]

    ["1", "2"].map(&:to_i).tapql.inject(&:+)
    # prints: bar.rb:12: [1, 2]

## Documentation

There's more.  Please see the [Full documentation][2] (relishapp).

## Rubies supported

This gem is known to work with these Rubies:

* ruby-1.9.3-p547
* ruby-2.0.0-p481
* ruby-2.1.2p95

## Platforms supported

This gem is developed and tested with Linux.  It should work on
Windows and OSX as well.  If it does not work for you, please file an
issue on github.

## Other gems with similar functions

The [_wrong_][1] gem includes the excellent #d method, which is very
much like this gem's #q method.  This gem's ability to read the debug
statement's source is derived from the _wrong_ gem.

Differences between the _wrong_ gem and this gem:

* The _wrong_ gem supports color output
* The _wrong_ gem writes only to stdout
* The _wrong_ gem supports Ruby 1.8

## Versioning

This gem uses [semantic versioning 2.0][3].

While the version is < 1.0.0, the API can change with any version
increment.  If you need stability, lock the gem down to a minor
version, e.g.:

    gem "cute_print", "~> 0.1.0"

## Contributing

1. Fork it ( http://github.com/wconrad/cute_print/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: http://rubygems.org/gems/wrong
[2]: https://www.relishapp.com/wconrad/cute-print/docs
[3]: http://semver.org/spec/v2.0.0.html
