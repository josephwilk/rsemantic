module Semantic
  module Transform
    class TFIDF

      @@number_of_documents_with_term = []

      def self.transform(matrix)
        number_of_documents = matrix.num_columns
        @@number_of_documents_with_term = []

        matrix.columns.each_with_index do |document, column_index|
          document_term_total = document.rows.inject(0.0) {|word_sum, word_count| word_sum + word_count.to_f }

          document.rows.each_with_index do |term_weight, row_index|
            unless term_weight.to_f == 0.0
              matrix[row_index, column_index] = (term_weight / document_term_total) *
              Math.log((number_of_documents / number_of_documents_with_term(row_index, matrix).to_f).abs)
            end
          end
        end
        matrix
      end

      def self.number_of_documents_with_term(row_index, matrix)
        return @@number_of_documents_with_term[row_index] unless @@number_of_documents_with_term[row_index].nil?

        term_document_occurences = 0

        rows,cols = matrix.dimensions

        for n in (0...cols)
          if matrix[row_index, n] > 0 #Term appears in document
            term_document_occurences += 1
          end
        end
        @@number_of_documents_with_term[row_index] = term_document_occurences
        @@number_of_documents_with_term[row_index]
      end

    end
  end
end
