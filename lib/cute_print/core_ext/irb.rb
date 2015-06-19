# Taken and then
# modified from the _wrong_ gem:
# https://github.com/sconover/wrong/blob/30475fc5ac9d0f73135d229b1b44c045156a7e7a/lib/wrong/irb.rb
# Thanks for showing the way

if defined? IRB
  module IRB
    class Context

      def all_lines
        @all_lines.join
      end

      original_evaluate = instance_method(:evaluate)

      # Save every line that is evaluated.  This gives cute_print a
      # way to get the source when it is run in irb.
      define_method :evaluate do |src, line_no|
        @all_lines ||= []
        @all_lines += ["\n"] * (line_no - @all_lines.size - 1)
        @all_lines += src.lines.to_a
        original_evaluate.bind(self).call src, line_no
      end

    end
  end
end
