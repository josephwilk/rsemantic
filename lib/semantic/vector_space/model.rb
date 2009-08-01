require 'linalg'
require 'delegate'
require 'stringio'

module Semantic
  module VectorSpace

    class Model < DelegateClass(::Linalg::DMatrix)

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
        out.print " " * 9
        
        matrix.ncol.times do |id|
          out.print "  D#{id+1}  " 
        end
        out.puts

        matrix.rows.each_with_index do |terms, index|
          out.print "#{@keywords.index(index).ljust(6)}" if @keywords.has_value?(index)
          out.print "[ "
          terms.columns.each do |document|
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
