Feature: Configure position format

  You can change the format which Kernel#ql uses to print the source
  position.  String#sprintf is called on the string you supply, with
  a hash argument having these keys:
    :path
    :filename
    :line_number
  The default position format is:
    "%<filename>s:%<line_number>d: "

  Scenario: Write full path
    Given a file named "example.rb" with:
      """
      require "print_debug"

      PrintDebug.configure do |c|
        c.position_format = "%<path>s:%<line_number>d: "
      end

      ql 123
      """
    Then stderr should match "^/tmp/.+/example\.rb:7: 123$"
