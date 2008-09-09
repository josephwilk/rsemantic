# Latent Semantic Analysis(LSA).
# Apply transforms to a document-term matrix to bring out latent relationships.
# These are found by analysing relationships between the documents and the terms they
# contain.
module Semantic
  class LSA

    def initialize(matrix)
      @matrix = Linalg::DMatrix.rows(matrix)
    end

    # Apply term_frequency(tf)*inverse_document_frequency(idf) for each matrix element.
    # This evaluates how important a word is to a document in a corpus
    #
    # With a document-term matrix: matrix[x][y]
    #   tf[x][y] = frequency of term y in document x / frequency of all terms in document x
    #   idf[x][y] = log( abs(total number of documents in corpus) / abs(number of documents with term y)  )
    # Note: This is not the only way to calculate tf*idf
    def tf_idf_transform!()
      number_of_documents = @matrix.num_rows
      number_of_documents_with_term=[]

      @matrix.rows.each_with_index do |document, row_index|

        document_word_total = document.columns.inject(0.0) {|word_sum, word_count| word_sum + word_count.to_f }

        document.columns.each_with_index do |term_weight, column_index|
          unless term_weight.to_f == 0.0

            number_of_documents_with_term[column_index] ||= get_term_document_occurences(column_index)

            tf = Frequency::term_frequency(term_weight.to_f, document_word_total)
            idf = Frequency::inverse_document_frequency(number_of_documents, number_of_documents_with_term[column_index])
            @matrix[row_index, column_index] =  tf * idf
          end
        end
      end
    end

    # Calculate SVD of objects matrix: U . SIGMA . VT = MATRIX
    # Reduce the dimension of sigma by specified factor producing sigma'.
    # Then dot product the matrices:  U . SIGMA' . VT = MATRIX'
    def lsa_transform!(dimensions=1)
      rows = @matrix.num_rows

      if dimensions <= rows: #Its a valid reduction

        u, sigma, vt = @matrix.singular_value_decomposition

        #Dimension reduction, build SIGMA'
        for index in ((rows-dimensions)...rows)
          sigma[index,index]=0
        end

        #Reconstruct MATRIX' and Save transform
        @matrix = u * sigma * vt

      else
        raise Exception, "dimension reduction cannot be greater than %s" % rows
      end
    end

    #Make the matrix look pretty
    def to_s()
      string_representation=""

      @matrix.rows.each do |document|

        string_representation += "[ "

        document.columns.each do |term|
          string_representation+= "%+0.2f " % term
        end
        string_representation += "]\n"
      end

      string_representation
    end

    def to_a()
      @matrix.to_a
    end

    private
    #Find how many documents a term occurs in
    def get_term_document_occurences(col)
      term_document_occurences=0

      rows,cols = @matrix.dimensions

      for n in (0...rows)
        if @matrix[n,col]>0 #Term appears in document
          term_document_occurences+=1
        end
      end
      return term_document_occurences
    end

  end

  class << self
    def main
      #Example document-term matrix
      #Vector dimensions: good, pet, hat, make, dog, cat, poni, fine, disabl
      matrix=[[0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0],
      [0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0],
      [1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]]

      #Create
      lsa = Semantic::LSA.new(matrix)
      puts "Inital matrix"
      puts lsa
      puts

      #Prepare
      lsa.tf_idf_transform!
      puts "Applying tf-idf transform"
      puts lsa
      puts

      #Perform
      lsa.lsa_transform!
      puts "Applying lsa transform"
      puts lsa
    end
  end
end
