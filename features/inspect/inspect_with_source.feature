Feature: Inspect with source

  Kernel#q, if given a block, prints the source for the block and then
  the inspected result of running the block.

  Scenario: Label and inspect an object
    Given a file with:
      """
      require "cute_print"
      q {1 + 2}
      """
    Then stderr should be
      """
      (1 + 2) is 3

      """
