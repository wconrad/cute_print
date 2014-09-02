Feature: Configure output

  By default, output is written to $stderr.  You can change where
  output goes.

  Scenario: Write to $stdout
    Given a file with:
      """
      require "cute_print"

      CutePrint.configure do |c|
        c.out = $stdout
      end

      q "abc"
      """
    Then stdout should be
      """
      "abc"

      """
