Feature: Inspect an object

  By default, output is written to $stderr.  You can change where
  output goes.

  Scenario: Write to $stdout
    Given a file with:
      """
      require "print_debug"

      PrintDebug.configure do |c|
        c.out = $stdout
      end

      q "abc"
      """
    Then stdout should be
      """
      "abc"

      """
