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
       
        document_vectors = documents.enum_for(:each_with_index).map{|document,document_id| build_vector(document, document_id)}
        document_matrix = Linalg::DMatrix.join_columns(document_vectors)
        
        Model.new(document_matrix, @vector_keyword_index)
      end

      def build_query_vector(term_list)
        build_vector(term_list.join(" "))
      end

      private
      def build_vector_keyword_index(documents)
        parse_and_cache(documents)
        vocabulary_list = find_unique_vocabulary
	      map_vocabulary_to_vector_positions(vocabulary_list)
      end

      def parse_and_cache(documents)
        documents.each_with_index do |document, index|
          @parsed_document_cache[index] = @parser.tokenise_and_filter(document)
        end
      end

      def find_unique_vocabulary
        vocabulary_list = @parsed_document_cache.inject([]) { |parsed_document, vocabulary_list| vocabulary_list + parsed_document  }
        vocabulary_list.uniq
      end
      
      def map_vocabulary_to_vector_positions(vocabulary_list)
        vector_index={}
        column = 0
	      vocabulary_list.each do |word|
          vector_index[word] = column
          column += 1
        end
        vector_index
      end 
    
      def build_vector(word_string, document_id=nil)
        if document_id.nil?
          word_list = @parser.tokenise_and_filter(word_string)
        else
          word_list = @parsed_document_cache[document_id]
        end
        
        vector = Linalg::DMatrix.new(@vector_keyword_index.length, 1)
        word_list.each { |word| vector[@vector_keyword_index[word] , 0] += 1 if @vector_keyword_index.has_key?(word)  }
        vector
      end

    end
  end
end