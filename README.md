# print_debug

Write debug output to stderr.  Optionally print the source filename
and line number, or the source of the debug statement.  Easily print
debug from the middle of call chains.

This is for those who prefer to debug by writing things to the
console.  Since it writes to stderr, it's more useful than Kernel#p
when working with a program that is run with stdout redirection.

Output goes to $stderr by default, but that's configurable.

## Installation

Add this line to your application's Gemfile:

    gem "print_debug"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install print_debug

## Usage

Start with:

    require "print_debug"

You can use q just like you use Kernel#p.  It will work the same,
except that its output goes to $stderr instead of $stdout:

    q "abc"            # prints: "abc"
    q [1, 2, 3 + 4]    # prints: [1, 2, 7]

You can have the debug source printed along with the value:

    i = 1
    j = 2
    q {1 + 2}         # prints: 1 + 2 is 3

Kernel#ql will add the source position:

    ql "abc"        # prints: foo.rb:12: "abc"
    ql {1 + 2}      # prints: foo.rb:13: 1 + 2 is 3

Call chains can be a pain to debug, but it's easy with #tapq:

    ["1", "2"].map(&:to_i).tapq.inject(&:+)
    # prints: [1, 2]

#tapql adds the source filename and line number:

    ["1", "2"].map(&:to_i).tapql.inject(&:+)
    # prints: bar.rb:12: [1, 2]

## Configuring

Change the output device:

    PrintDebug.configure do |c|
      c.out = $stdout
    end

Causes #ql and #tapql to print the full path rather than just the
filename:

    PrintDebug.configure do |c|
      c.position_format = "%<path>s:%<line_number>d: "
    end

## Rubies supported

This gem is known to work with these Ruby implementations:

* ruby-1.9.3
* ruby 2.1.2

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

## Contributing

1. Fork it ( http://github.com/<my-github-username>/print_debug/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: http://rubygems.org/gems/wrong
