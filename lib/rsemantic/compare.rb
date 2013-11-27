module RSemantic
  class Compare

    class << self
      
      def similarity(vector1, vector2)
        cosine(vector1, vector2)
      end
      
      def cosine(vector1, vector2)
        unless vector2.nil? or vector1.nil?
          v1 = vector1.row
          v2 = vector2
          score =  (v1 * v2) / (vector1.norm * vector2.norm)
          score.nan? ?  0.0 : score
        end
      end

    end
    
  end
end
