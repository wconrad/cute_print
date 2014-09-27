### Development

Breaking changes:

* Configure.out must respond to #print rather than #puts

Enhancements:

* Added Kernel#tapqq (call chain pretty-print)
* Added Kernel#tapqql (call chain pretty-print, with source location)

Bug fixes:

* Works in irb (issue #1)
* Is now thread safe (issue #4)

### 0.2.0 / 2014-09-05

Breaking changes:

* Configure.position_format removed
* Added Configure.location_format, which takes either :filename or
  :path

Enhancements:

* Kernel#ql with no arguments prints source location
* Added Kernel#qq (pretty-print)
* Added Kernel#qql (pretty-print with source location)

### 0.1.0 / 2014-09-04

Initial release
