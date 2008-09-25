module Semantic
  module Frequency

    class << self

      def term_frequency(term_weight, document_word_total)
        term_weight / document_word_total
      end

      def inverse_document_frequency(number_of_documents, number_of_documents_with_term)
        Math.log((number_of_documents / number_of_documents_with_term.to_f).abs)
      end

    end
    
  end
end
