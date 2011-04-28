module Semantic
  module Transform
    class LSA

      class << self

        def transform!(matrix, rank = nil)
          # TODO configurable rank
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
        
          if rank.nil?
            rank = determine_rank(vector)
          else
            rank = valid_rank(vector, rank)
          end

          num_to_zero_out = vector.size - rank
          vector[rank, num_to_zero_out] = 0
        end

        def determine_rank(vector)
          if vector.size <= 15
            # for less than 15 documents, n-1 is usually the best we
            # can do. LSA generally works better with bigger data
            # sets.
            rank = vector.size - 1
          elsif vector.size <= 1000
            # ~500 is a value to work well for really big data sets,
            # but for less than that, it probably is too big, so we
            # go for n/3 in this case.
            rank = vector.size / 3
          else
            # if we have more than 1000 documents, using the magical
            # number 500 (which can be found in various documents)
            # seems to be the best guess for now.
            rank = 500
          end
        end
        
        def valid_rank(vector, rank)
          if rank <= 0
            # for negative ranks, keep that many dimensions
            rank = vector.size + rank
          elsif rank > vector.size
            # if the rank is > the vector size, limit it to that
            rank = vector.size
          else
            rank
          end
        end
        
      end
    end
  end
end
