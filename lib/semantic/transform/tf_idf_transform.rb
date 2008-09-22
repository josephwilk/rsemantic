module Semantic
  module Transform
    class TFIDF

      class << self

        # Apply term_frequency(tf)*inverse_document_frequency(idf) for each matrix element.
        # This evaluates how important a word is to a document in a corpus
        #
        # With a document-term matrix: matrix[x][y]
        #   tf[x][y] = frequency of term y in document x / frequency of all terms in document x
        #   idf[x][y] = log( abs(total number of documents in corpus) / abs(number of documents with term y)  )
        # Note: This is not the only way to calculate tf*idf
        def transform(matrix)
          number_of_documents = matrix.num_rows
          number_of_documents_with_term=[]

          matrix.rows.each_with_index do |document, row_index|

            document_word_total = document.columns.inject(0.0) {|word_sum, word_count| word_sum + word_count.to_f }

            document.columns.each_with_index do |term_weight, column_index|
              unless term_weight.to_f == 0.0

                number_of_documents_with_term[column_index] ||= self.get_term_document_occurences(column_index, matrix)

                tf = Frequency::term_frequency(term_weight.to_f, document_word_total)
                idf = Frequency::inverse_document_frequency(number_of_documents, number_of_documents_with_term[column_index])
                matrix[row_index, column_index] =  tf * idf
              end
            end
          end
   
          matrix
        end

        #Find how many documents a term occurs in
        def get_term_document_occurences(col, matrix)
          term_document_occurences=0

          rows,cols = matrix.dimensions

          for n in (0...rows)
            if matrix[n,col]>0 #Term appears in document
              term_document_occurences+=1
            end
          end
          term_document_occurences
        end

      end

    end
  end
end
