module RSemantic
  class MatrixTransformer

    def initialize(transforms)
      @transforms = transforms
    end

    def apply_transforms(vector_space_model)
      @transforms.each do |transform|
        begin
          transform_class = RSemantic::Transform.const_get(transform)
          RSemantic.logger.info("Applying #{transform} transform")
          transform_class.transform!(vector_space_model.matrix)
          RSemantic.logger.info(vector_space_model)
        rescue => e
          RSemantic.logger.error("Error: Cannot perform transform: #{transform}")
          RSemantic.logger.error(e)
        end
      end
      vector_space_model
    end

  end
end
