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

  Scenario: Pretty print
    Given a file with:
      """
      require "cute_print"
      a = [
        "Once upon a time there were four little Rabbits, and their names were",
        "Flopsy,",
        "Mopsy,",
        "Cotton-tail, and",
        "Peter.",
      ]
      puts a.tapqq.map(&:size).inject(&:+)
      """
    Then stdout should be
      """
      104

      """
    And stderr should be
      """
      ["Once upon a time there were four little Rabbits, and their names were",
       "Flopsy,",
       "Mopsy,",
       "Cotton-tail, and",
       "Peter."]
 
      """

  Scenario: Pretty print with source location
    Given a file with:
      """
      require "cute_print"
      a = [
        "Once upon a time there were four little Rabbits, and their names were",
        "Flopsy,",
        "Mopsy,",
        "Cotton-tail, and",
        "Peter.",
      ]
      puts a.tapqql.map(&:size).inject(&:+)
      """
    Then stdout should be
      """
      104

      """
    And stderr should be
      """
      example.rb:9: ["Once upon a time there were four little Rabbits, and their names were",
                     "Flopsy,",
                     "Mopsy,",
                     "Cotton-tail, and",
                     "Peter."]
 
      """
