module Semantic
  class Search

    def initialize(documents, options={})
      Semantic.logger.level = options[:verbose] ? Logger::INFO : Logger::ERROR

      @builder = VectorSpace::Builder.new(options)
      @matrix_transformer = MatrixTransformer.new(options)

      @vector_space_model = @builder.build_document_matrix(documents)

      Semantic.logger.info(@vector_space_model)

      @vector_space_model = @matrix_transformer.apply_transforms(@vector_space_model)
    end

    def related(documentId)
      ratings = []
      for index in (0...@vector_space_model.size2)
        ratings << Compare.similarity(@vector_space_model.column(documentId), @vector_space_model.column(index))
      end
      ratings
    end

    def search(searchList)
      ratings = []
      query_vector = @builder.build_query_vector(searchList)
      for index in (0...@vector_space_model.size2)
        ratings << Compare.similarity(query_vector, @vector_space_model.column(index))
      end
      ratings
    end

  end
end
