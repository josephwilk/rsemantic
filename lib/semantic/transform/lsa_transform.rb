module Semantic
  module Transform
    class LSA

      class << self

        def transform(matrix, number_of_dimensions_to_reduce = 1)
          columns = matrix.num_columns

          if dimensions <= columns: #Its a valid reduction

            u, sigma, vt = matrix.singular_value_decomposition

            sigma_prime = reduce_dimensions(number_of_dimensions_to_reduce, sigma)

            #Reconstruct MATRIX' and Save transform
            matrix_prime = u * sigma_prime * vt

          else
            raise Exception, "dimension reduction cannot be greater than %s" % rows
          end
          
          matrix_prime
        end
        
        private
        def reduce_dimensions(number_of_dimensions_to_reduce, matrix)
          columns = matrix.num_columns
          for index in ((columns-number_of_dimensions_to_reduce)...columns)
            matrix[index,index] = 0
          end
          matrix
        end
        
      end
    end
  end
end