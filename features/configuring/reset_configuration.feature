Feature: Reset configuration

  You can reset the configuration to its defaults.

  Scenario: Write to $stdout
    Given a file with:
      """
      require "cute_print"

      CutePrint.configure { |c| c.out = $stdout }
      q "abc"
      CutePrint.configure { |c| c.reset }
      q 123
      """
    Then stdout should be
      """
      "abc"

      """
    And stderr should be
      """
      123

      """
