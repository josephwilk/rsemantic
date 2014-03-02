module RSemantic
  class Search

    def initialize(documents, options = {})
      options = {
        :transforms => [:TFIDF, :LSA],
        :verbose    => false,
        :filter_stop_words => true,
        :stem_words => true,
      }.merge(options)
      RSemantic.logger.level = options[:verbose] ? Logger::INFO : Logger::ERROR


      @builder = VectorSpace::Builder.new(
        :filter_stop_words => options[:filter_stop_words],
        :stem_words => options[:stem_words],
        :locale => options[:locale]
      )
      @matrix_transformer = MatrixTransformer.new(options[:transforms])

      @vector_space_model = @builder.build_document_matrix(documents)

      RSemantic.logger.info(@vector_space_model)

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

    protected

    def marshal_dump
      [@builder, @matrix_transformer, @vector_space_model.to_a]
    end

    def marshal_load(array)
      @builder = array.shift
      @matrix_transformer = array.shift
      @vector_space_model = GSL::Matrix.alloc(*array.shift)
    end
  end
end
