# development

* Support Ruby 2.6 and 2.7
* Drop support for Ruby 2.4
* Update gems

# 1.3.0 - 2018-03-13

* Rubies prior to 2.2 are no longer supported.
* Update gems
* No longer require hirb gem
* Removed warnings in Rubies 2.4 and 2.5

# 1.2.0 - 2017-07-25

* Remove jeweler gem as a development dependency
* Added CutePrint::Release with version and release date constants
* Update gems

# 1.1.4 - 2016-06-15

* Update gems

# 1.1.3 - 2016-02-22

* Update gems

# 1.1.2 - 2016-01-24

* Update gems

# 1.1.1 - 2015-11-17

* Update gems

* Fix stack trace in irb when used after function definition

* 1.1.0 - 2015-06-13

Enhancements:

* Determine the terminal width and use it instead of just hard-coding
  "79"

API changes

* Added Configure#term_width to set the term width

# 1.0.1 - 2014-12-21

* Eliminate warnings in "-w" mode

# 1.0.0 - 2014-12.13

* Declare API stability with advent of v. 1.0.0
* Update gems

# 0.4.0 - 2014-10-25

API changes

* Can be used without patching any core Ruby classes (see README)
* Use fewer output lines when possible while better respecting term width

# 0.3.0 - 2014-09-27

Breaking changes:

* Configure.out must respond to #print rather than #puts
* Kernel#q, #qq and #qql return nil

Enhancements:

* Added Kernel#tapqq (call chain pretty-print)
* Added Kernel#tapqql (call chain pretty-print, with source location)

Bug fixes:

* Works in irb (issue #1)
* Is now thread safe (issue #4)

# 0.2.0 - 2014-09-05

Breaking changes:

* Configure.position_format removed
* Added Configure.location_format, which takes either :filename or
  :path

Enhancements:

* Kernel#ql with no arguments prints source location
* Added Kernel#qq (pretty-print)
* Added Kernel#qql (pretty-print with source location)

# 0.1.0 / 2014-09-04

Initial release
