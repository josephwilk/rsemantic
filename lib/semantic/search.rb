module Semantic
  class Search

    def initialize(documents, options={})
      Semantic.logger.level = Logger::INFO if options[:verbose]
      
      @builder = VectorSpace::Builder.new(options)
      @matrix_transformer = MatrixTransformer.new(options)

      #Map documents to vector space
      @document_matrix = @builder.build_document_matrix(documents)
      
      Semantic.logger.info(@document_matrix)
      
      @document_matrix = @matrix_transformer.apply_transforms(@document_matrix)
    end
  
    def related(documentId)
      ratings = []
      for index in (0...@document_matrix.ncol)
        ratings << Compare.similarity(@document_matrix.column(documentId), @document_matrix.column(index))
      end
      ratings
    end

    def search(searchList)
      ratings = []
      query_vector = @builder.build_query_vector(searchList)
      
      for index in (0...@document_matrix.ncol)
        ratings << Compare.similarity(query_vector, @document_matrix.column(index))
      end
      ratings
    end
  
  end
end
