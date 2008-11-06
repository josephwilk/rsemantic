module Semantic
  class Compare

    class << self
      
      def similarity(vector1, vector2)
        cosine(vector1, vector2)
      end
      
      #Related documents j and q are in the concept space by comparing the vectors :
      #cosine  = ( V1 * V2 ) / ||V1|| x ||V2||
      def cosine(vector1, vector2)
        unless vector2.nil? or vector1.nil?
          (vector2.dot(vector1)) / (vector1.norm * vector2.norm)
        end
      end

    end
    
  end
end
