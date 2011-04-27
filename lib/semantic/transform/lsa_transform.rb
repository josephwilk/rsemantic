module Semantic
  module Transform
    class LSA

      class << self

        def transform!(matrix, rank = 3)
          # TODO find a smart way to determine a sensible rank
          columns = matrix.size2

          u, v, sigma = matrix.SV_decomp_mod
          reduce_dimensions!(sigma, rank)
          sigma = GSL::Matrix.diagonal(sigma)

          GSL::Matrix.swap(matrix, u * sigma * v.transpose)
        end

        private
        def reduce_dimensions!(vector, rank)
          # the vector is already sorted (biggest to smallest), so we
          # only have to zero the elements we do not want
          if rank > vector.size
            rank = vector.size
          end

          num_to_zero_out = vector.size - rank
          vector[rank, num_to_zero_out] = 0
        end
      end
    end
  end
end
