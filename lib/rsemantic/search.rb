module RSemantic
  class Search

    def initialize(documents, options = {})
      options = {
        :transforms => [:TFIDF, :LSA],
        :verbose    => false,
        :filter_stop_words => true,
        :stem_words => true,
      }.merge(options)
      Semantic.logger.level = options[:verbose] ? Logger::INFO : Logger::ERROR


      @builder = VectorSpace::Builder.new(:filter_stop_words => options[:filter_stop_words], :stem_words => options[:stem_words])
      @matrix_transformer = MatrixTransformer.new(options[:transforms])

      @vector_space_model = @builder.build_document_matrix(documents)

      Semantic.logger.info(@vector_space_model)

      @vector_space_model = @matrix_transformer.apply_transforms(@vector_space_model)
    end

    def related(document_id)
      ratings = []
      @vector_space_model.each_column do |column|
        ratings << Compare.similarity(@vector_space_model.column(document_id), column)
      end
      ratings
    end

    def search(search_list)
      ratings = []
      query_vector = @builder.build_query_vector(search_list)
      @vector_space_model.each_column do |column|
        ratings << Compare.similarity(query_vector.col, column)
      end
      ratings
    end
  end
end
