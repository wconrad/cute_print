Feature: Pretty-print an object

  Kernel#pp, if given a block, prints the source for the block and then
  the pretty-printed result of running the block.

  Scenario: Label and pretty-print an object
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
      qq {a}
      """
    Then stderr should be
      """
      a is ["Once upon a time there were four little Rabbits, and their names were",
            "Flopsy,",
            "Mopsy,",
            "Cotton-tail, and",
            "Peter."]
 
      """
