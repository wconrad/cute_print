Feature: Pretty-print an object

  Kernel#qq pretty-prints its arguments and prints them, one per line.  This
  is just like Kernel#pp from the pp library, except that it writes to $stderr
  by default.

  Scenario: One argument
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
      qq a
      """
    Then stderr should be
      """
      ["Once upon a time there were four little Rabbits, and their names were",
       "Flopsy,",
       "Mopsy,",
       "Cotton-tail, and",
       "Peter."]
 
      """

  Scenario: Two arguments
    Given a file with:
      """
      require "cute_print"
      qq 1, "foo"
      """
    Then stderr should be
      """
      1
      "foo"

      """
