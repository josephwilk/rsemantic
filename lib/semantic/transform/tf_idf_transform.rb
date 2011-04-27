module Semantic
  module Transform
    class TFIDF

      @@number_of_documents_with_term = []

      def self.transform(matrix)
        number_of_documents = matrix.size2
        @@number_of_documents_with_term = []

        matrix.to_a.transpose.each_with_index do |document, column_index|
          document_term_total = document.inject(0.0) {|word_sum, word_count| word_sum + word_count.to_f }

          document.to_a.each_with_index do |term_weight, row_index|
            unless term_weight.to_f == 0.0
              matrix[row_index, column_index] = (term_weight / document_term_total) *
              Math.log((number_of_documents / number_of_documents_with_term(row_index, matrix).to_f).abs)
            end
          end
        end
        matrix
      end

      def self.number_of_documents_with_term(row_index, matrix)
        @@number_of_documents_with_term[row_index] ||= matrix.row(row_index).where.size
      end

    end
  end
end
