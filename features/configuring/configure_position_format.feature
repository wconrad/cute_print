Feature: Configure location format

  You can change the format which Kernel#ql uses to print the source
  location.  By default, just the filename is printed, but you can
  cause the full path. to be printed instead.

  Scenario: Write full path
    Given a file named "example.rb" with:
      """
      require "cute_print"

      CutePrint.configure do |c|
        c.location_format = :path
      end

      ql 123
      """
    Then stderr should be
    """
    /tmp/.../example.rb:7: 123

    """

  Scenario: Write filename
    Given a file named "example.rb" with:
      """
      require "cute_print"

      CutePrint.configure do |c|
        c.location_format = :filename
      end

      ql 123
      """
    Then stderr should be
    """
    example.rb:7: 123

    """
