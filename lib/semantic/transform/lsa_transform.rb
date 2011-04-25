module Semantic
  module Transform
    class LSA

      class << self

        def transform(matrix, number_of_dimensions_to_reduce = 1)
          columns = matrix.size2

          if number_of_dimensions_to_reduce <= columns #Its a valid reduction
            # u, sigma, vt = matrix.singular_value_decomposition
            u, vt, sigma = matrix.SV_decomp
            sigma = GSL::Matrix.diagonal(sigma)

            sigma_prime = reduce_dimensions(number_of_dimensions_to_reduce, sigma)
            # sigma_prime = sigma

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
          matrix.size2 < matrix.size1 ? matrix.size2 : matrix.size1
        end

      end
    end
  end
end
