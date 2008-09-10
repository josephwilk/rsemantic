module Semantic

  class Compare

    class << self
      #Related documents j and q are in the concept space by comparing the vectors :
      #cosine  = ( V1 * V2 ) / ||V1|| x ||V2||
      def cosine(vector1, vector2)
        (vector2.transpose.dot(vector1.transpose)) / (vector1.norm * vector2.norm)
      end

    end

  end


end
