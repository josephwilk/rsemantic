module Semantic
  class Compare

    class << self
      
      def similarity(vector1, vector2)
        cosine(vector1, vector2)
      end
      
      def cosine(vector1, vector2)
        unless vector2.nil? or vector1.nil?
          score = (vector2.dot(vector1)) / (vector1.norm * vector2.norm)
          score.nan? ?  0.0 : score
        end
      end

    end
    
  end
end
