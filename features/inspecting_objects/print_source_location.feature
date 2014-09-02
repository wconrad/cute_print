Feature: Print the source location

  Kernel#ql works just like Kernel#q, except that it also prints the
  source location

  Scenario: Inspect an object
    Given a file named "example.rb" with:
      """
      require "cute_print"
      ql "abc"
      """
    Then stderr should be
      """
      example.rb:2: "abc"

      """

  Scenario: Inspect two objects
    Given a file named "example.rb" with:
      """
      require "cute_print"
      ql "abc", 123
      """
    Then stderr should be
      """
      example.rb:2: "abc"
      example.rb:2: 123

      """

  Scenario: Label and inspect and object
    Given a file named "example.rb" with:
      """
      require "cute_print"
      ql {1 + 2}
      """
    Then stderr should be
      """
      example.rb:2: (1 + 2) is 3

      """
