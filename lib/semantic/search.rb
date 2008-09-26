module Semantic
  class Search

    def initialize(documents, options={})
      @builder = VectorSpace::Builder.new(options)
      @matrix_transformer = MatrixTransformer.new(options)

      #Map documents to vector space
      @document_matrix = @builder.build_document_matrix(documents)
      @document_matrix = @matrix_transformer.apply_transforms(@document_matrix)
    end
  
    def related(documentId)
      ratings = []
      for index in (0...@document_matrix.nrow)
        ratings << Compare.similarity(@document_matrix.row(documentId), @document_matrix.row(index))
      end
      ratings
    end

    def search(searchList)
      ratings = []
      query_vector = @builder.build_query_vector(searchList)
      
      for index in (0...@document_matrix.nrow)
        ratings << Compare.similarity(query_vector, @document_matrix.row(index))
      end
      ratings
    end
  
  end
end
