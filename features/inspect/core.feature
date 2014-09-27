Feature: Core functionality

  cute_print, by default, adds a fair number of methods to Object,
  making them available globally.  You can use cute_print without any
  changes to Object, by requiring "cute_print/core" instead of
  "cute_print".

  Scenario: Inspect an object
    Given a file with:
      """
      require "cute_print/core"
      CutePrint.q "abc"
      """
    Then stderr should be
      """
      "abc"

      """
