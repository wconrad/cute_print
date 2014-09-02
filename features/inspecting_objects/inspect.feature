Feature: Inspect an object

  Kernel#q inspects its arguments and prints them, one per line.  This
  is just like Kernel#p, except that it writes to $stderr by default.

  Scenario: One argument
    Given a file with:
      """
      require "print_debug"
      q "abc"
      """
    Then stderr should be
      """
      "abc"

      """

  Scenario: Two arguments
    Given a file with:
      """
      require "print_debug"
      q "abc", 123
      """
    Then stderr should be
      """
      "abc"
      123

      """
