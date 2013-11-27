require File.dirname(__FILE__) + '/../spec_helper'

module Semantic
  describe MatrixTransformer do
    let(:mock_transform){ mock(Transform) }
    let(:mock_vector_space){ mock("vector space", :matrix => GSL::Matrix[[1,0],[0,1]], :matrix= => nil ) }

    describe "transforming matrix" do

      it "should ignore invalid transform class" do
        matrix_transformer = MatrixTransformer.new(:transforms => [:FAKE])
        lambda {
          matrix_transformer.apply_transforms(mock_vector_space)
        }.should_not raise_error
      end

      it "should send transform message to class to transform matrix" do
        matrix_transformer = MatrixTransformer.new(:transforms => [:LSA])
        Transform.stub!(:const_get).and_return(mock_transform)

        mock_transform.should_receive(:transform!)

        matrix_transformer.apply_transforms(mock_vector_space)
      end

      it "should log an error if the transform class is not capable of transforming" do
        class DudTransform
        end
        
        matrix_transformer = MatrixTransformer.new(:transforms => [:DudTransform])
        Transform.stub!(:const_get).and_return(DudTransform.new)

        matrix_transformer.apply_transforms(mock_vector_space)
      end

    end
  end
end
