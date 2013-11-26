module Semantic
  class MatrixTransformer

    def initialize(transforms)
      @transforms = transforms
    end

    def apply_transforms(vector_space_model)
      @transforms.each do |transform|
        begin
          transform_class = Semantic::Transform.const_get(transform)
          Semantic.logger.info("Applying #{transform} transform")
          transform_class.transform!(vector_space_model.matrix)
          Semantic.logger.info(vector_space_model)
        rescue => e
          Semantic.logger.error("Error: Cannot perform transform: #{transform}")
          Semantic.logger.error(e)
        end
      end
      vector_space_model
    end

  end
end
