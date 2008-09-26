module Semantic
  class MatrixTransformer

    def initialize(options={})
      @transforms = options[:transforms] || [:TFIDF, :LSA]
      @options = options
    end

    def apply_transforms(matrix)
      @transforms.each do |transform|
        begin
          transform_class = Semantic::Transform.const_get(transform)
          Semantic.logger.info("Applying #{transform} transform")
          matrix = transform_class.send(:transform, matrix) if transform_class.respond_to?(:transform)
          Semantic.logger.info(matrix)
        rescue Exception => e
          Semantic.logger.error("Error: Cannot perform transform: #{transform}")
          Semantic.logger.error(e)
        end
      end
      matrix
    end

  end
end
