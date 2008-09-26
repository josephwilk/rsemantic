module Semantic
  module VectorSpace
    #A algebraic model for representing text documents as vectors of identifiers.
    #A document is represented as a vector. Each dimension of the vector corresponds to a
    #separate term. If a term occurs in the document, then the value in the vector is non-zero.
    class Builder

      def initialize(options={})
        @parser = Parser.new
        @options = options
        @parsed_document_cache = []
      end

      def build_document_matrix(documents)
        @vector_keyword_index = build_vector_keyword_index(documents)
        document_vectors = documents.enum_for(:each_with_index).map{|document,document_id| build_vector_from_document(document, document_id)}
        document_matrix = Linalg::DMatrix.join_rows(document_vectors)
      end

      #Convert query string into a term vector
      def build_query_vector(term_list)
        build_vector_from_string(term_list.join(" "))
      end

      private
      #Create the keyword associated to the position of the elements within the document vectors
      def build_vector_keyword_index(document_list)
        document_list.each_with_index do |document, index|
          @parsed_document_cache[index] = @parser.tokenise_and_filter(document)
        end

        vocabulary_list = @parsed_document_cache.inject([]) { |parsed_document, vocabulary_list| vocabulary_list + parsed_document  }
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

      def build_vector_from_document(document_string, document_id)
        word_list = @parsed_document_cache[document_id] || @parser.tokenise_and_filter(document_string)
        build_vector(word_list)
      end

      def build_vector_from_string(word_string)
        word_list = @parser.tokenise_and_filter(word_string)
        build_vector(word_list)
      end

      #Create the keyword associated to the position of the elements within the document vectors
      #@pre: unique(@vector_keyword_index)
      def build_vector(word_list)
        vector = Linalg::DMatrix.new(1, @vector_keyword_index.length)
        word_list.each { |word| vector[0, @vector_keyword_index[word]] += 1 if @vector_keyword_index.has_key?(word)  }
        vector
      end

    end
  end
end
