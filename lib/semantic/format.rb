module Semantic
  class Format

    class << self

      #Make the matrix look pretty
      def pretty_print(matrix)
        string_representation=""

        matrix.rows.each do |document|

          string_representation += "[ "

          document.columns.each do |term|
            string_representation+= "%+0.2f " % term
          end
          string_representation += "]\n"
        end

        string_representation
      end

    end
  end
end