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
          log("Applying #{transform} transform")
          matrix = transform_class.send(:transform, matrix) if transform_class.respond_to?(:transform)
          log(matrix)
        rescue Exception => e
          puts("Error: Cannot perform transform: #{transform}")
          puts(e)
        end
      end
      matrix
    end

    #TODO: refactor out this duplication. Pass logger object into constructor?
    def log(string)
      puts string if @options[:verbose]
    end

  end
end
