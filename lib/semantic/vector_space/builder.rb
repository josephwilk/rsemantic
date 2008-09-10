module Semantic

  module VectorSpace

    #A algebraic model for representing text documents as vectors of identifiers.
    #A document is represented as a vector. Each dimension of the vector corresponds to a
    #separate term. If a term occurs in the document, then the value in the vector is non-zero.
    class Builder

      def initialize
        @parser = Parser.new
      end

      #Create the vector space for the passed document strings
      def build(documents)
        @vector_keyword_index = get_vector_keyword_index(documents)
        documents.map {|document| build_vector(document) }
      end

      #Create the keyword associated to the position of the elements within the document vectors
      def get_vector_keyword_index(documentList)
        #Mapped documents into a single word string
        vocabulary_string = documentList.join(" ")
        vocabulary_list = @parser.tokenise(vocabulary_string)

        #Remove common words which have no search value
        vocabulary_list = @parser.remove_stop_words(vocabulary_list)
        unique_vocabulary_list = vocabulary_list.uniq

        vector_index={}
        offset=0

        #Associate a position with the keywords which maps to the dimension on the vector used to represent this word
        for word in unique_vocabulary_list
          vector_index[word]=offset
          offset+=1
        end
        vector_index  #(keyword:position)
      end

      #Create the keyword associated to the position of the elements within the document vectors
      #@pre: unique(vectorIndex)
      def build_vector(word_string)
        #Initialises vector with 0's
        vector = Linalg::DMatrix.new(1, @vector_keyword_index.length)
        word_list = @parser.tokenise(word_string)
        word_list = @parser.remove_stop_words(word_list)
        word_list.each { |word| vector[0, @vector_keyword_index[word]] += 1  }
        vector
      end

      #Convert query string into a term vector
      def build_query_vector(termList)
        build_vector(termList.join(" "))
      end

    end
  end
end