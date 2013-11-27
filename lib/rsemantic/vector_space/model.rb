require 'gsl'
require 'delegate'
require 'stringio'

module RSemantic
  module VectorSpace

    class Model < DelegateClass(::GSL::Matrix)
      def initialize(matrix, keywords)
        @keywords = keywords || {}
        @_dc_obj = matrix
        super(matrix)
      end

      def matrix=(matrix)
        @_dc_obj = matrix
      end

      def matrix
        @_dc_obj
      end

      def to_s
        out = StringIO.new
        out.print " " * 12

        matrix.size2.times do |id|
          out.print "  D#{id+1}  "
        end
        out.puts

        matrix.to_a.each_with_index do |terms, index|

          if @keywords.has_value?(index)
            index_position = @keywords.values.index(index)
            key = @keywords.keys[index_position]

            out.print "#{key.ljust(10)}"
          end
          out.print "[ "

          terms.each do |document|
            out.print "%+0.2f " % document
          end
          out.print "]"
          out.puts
        end

        out.string
      end

    end
  end
end
