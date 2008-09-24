module Semantic
  class Search

    def initialize(documents, opts={})
      @builder = VectorSpace::Builder.new(opts)

      #Map documents to vector space
      @document_vectors = @builder.build(documents)
    end
  
    def related(documentId)
      ratings = []
      for index in (0...@document_vectors.nrow)
        ratings << Compare.similarity(@document_vectors.row(documentId), @document_vectors.row(index))
      end
      ratings
    end

    def search(searchList)
      ratings = []
      query_vector = @builder.build_query_vector(searchList)
      
      for index in (0...@document_vectors.nrow)
        ratings << Compare.similarity(query_vector, @document_vectors.row(index))
      end
      ratings
    end
  
  end
end
