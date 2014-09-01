Feature: Configure output

  You can reset the configuration to itse defaults.

  Scenario: Write to $stdout
    Given a file with:
      """
      require "print_debug"

      PrintDebug.configure do |c|
        c.out = $stdout
      end

      q "abc"
      PrintDebug.configure { |c| c.reset }
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
