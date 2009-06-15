module Semantic
  module Transform
    class LSA

      class << self

        def transform(matrix, number_of_dimensions_to_reduce = 1)
          columns = matrix.num_columns

          if number_of_dimensions_to_reduce <= columns #Its a valid reduction
            u, sigma, vt = matrix.singular_value_decomposition

            sigma_prime = reduce_dimensions(number_of_dimensions_to_reduce, sigma)

            matrix_prime = u * sigma_prime * vt
          else
            raise Exception, "dimension reduction cannot be greater than %s" % columns
          end
          
          matrix_prime
        end
        
        private
        def reduce_dimensions(number_of_dimensions_to_reduce, matrix)
          for diagonal_index in dimensions_to_be_reduced(matrix, number_of_dimensions_to_reduce)
            matrix[diagonal_index, diagonal_index] = 0
          end
          matrix
        end
        
        def dimensions_to_be_reduced(matrix, number_of_dimensions_to_reduce)
          (diagonal_matrix_length(matrix) - number_of_dimensions_to_reduce)...diagonal_matrix_length(matrix)
        end
        
        def diagonal_matrix_length(matrix)
          matrix.num_columns < matrix.num_rows ? matrix.num_columns : matrix.num_rows
        end
        
      end
    end
  end
end