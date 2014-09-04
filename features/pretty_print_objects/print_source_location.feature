Feature: Print the source location

  Kernel#qql works just like Kernel#pp from the built-in pp library,
  except that it writes to $stderr _and_ it prints the source
  location:

  Scenario: One argument
    Given a file named "example.rb" with:
      """
      require "cute_print"
      a = [
        "Once upon a time there were four little Rabbits, and their names were",
        "Flopsy,",
        "Mopsy,",
        "Cotton-tail, and",
        "Peter.",
      ]
      qql a
      """
    Then stderr should be
      """
      example.rb:9: ["Once upon a time there were four little Rabbits, and their names were",
                     "Flopsy,",
                     "Mopsy,",
                     "Cotton-tail, and",
                     "Peter."]
 
      """

  Scenario: Two arguments
    Given a file named "example.rb" with:
      """
      require "cute_print"
      qql 1, "foo"
      """
    Then stderr should be
      """
      example.rb:2: 1
      example.rb:2: "foo"

      """
