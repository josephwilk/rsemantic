module Semantic
  module Transform
    class LSA

      class << self

        # Calculate SVD of objects matrix: U . SIGMA . VT = MATRIX
        # Reduce the dimension of sigma by specified factor producing sigma'.
        # Then dot product the matrices:  U . SIGMA' . VT = MATRIX'
        def transform(matrix, dimensions=1)
          columns = matrix.num_columns

          if dimensions <= columns: #Its a valid reduction

            u, sigma, vt = matrix.singular_value_decomposition

            #Dimension reduction, build SIGMA'
            for index in ((columns-dimensions)...columns)
              sigma[index,index]=0
            end

            #Reconstruct MATRIX' and Save transform
            matrix = u * sigma * vt

          else
            raise Exception, "dimension reduction cannot be greater than %s" % rows
          end
          
          matrix
        end
      end
    end
  end
end