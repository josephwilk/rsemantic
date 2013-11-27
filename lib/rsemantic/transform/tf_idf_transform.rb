module Semantic
  module Transform
    class TFIDF

      @@number_of_documents_with_term = []
      def self.transform!(matrix)
        number_of_documents = matrix.size2
        @@number_of_documents_with_term = []

        matrix.transpose.enum_for(:each_row).with_index do |document, column_index|
          document.enum_for(:each).with_index do |term_weight, row_index|
            unless term_weight == 0.0
              inverse_document_frequency = 1 + GSL::Sf.log(number_of_documents / (number_of_documents_with_term(row_index, matrix).to_f + 1))
              term_frequency = Math.sqrt(term_weight)

              matrix[row_index, column_index] = term_frequency * inverse_document_frequency
            end
          end
        end
      end

      def self.number_of_documents_with_term(row_index, matrix)
        @@number_of_documents_with_term[row_index] ||= matrix.row(row_index).where.size
      end

    end
  end
end
