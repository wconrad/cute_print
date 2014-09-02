Feature: Inspect a call chain

  Call chains (aka "train wrecks") can be a bother to debug.
  Kernel#tapq prints a value in a call chain and then continues the
  chain.

  Scenario: Without source position
    Given a file with:
      """
      require "cute_print"
      puts ["1", "2"].map(&:to_i).tapq.inject(:+)
      """
    Then stdout should be
      """
      3

      """
    And stderr should be
      """
      [1, 2]

      """

  Scenario: With source position
    Given a file named "example.rb" with:
      """
      require "cute_print"
      puts ["1", "2"].map(&:to_i).tapql.inject(:+)
      """
    Then stdout should be
      """
      3

      """
    And stderr should be
      """
      example.rb:2: [1, 2]

      """
