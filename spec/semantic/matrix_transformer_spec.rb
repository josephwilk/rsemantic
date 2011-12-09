require File.dirname(__FILE__) + '/../spec_helper'

module Semantic
  describe MatrixTransformer do

    def mock_transform
      @transform ||= mock(Transform)
    end

    def mock_vector_space
      mock("vector space", :matrix => GSL::Matrix[[1,0],[0,1]], :matrix= => nil )
    end


    describe "transforming matrix" do

      it "should ignore invalid transform class" do
        matrix_transformer = MatrixTransformer.new(:transforms => [:FAKE])
        lambda {
          matrix_transformer.apply_transforms(mock_vector_space)
        }.should_not raise_error
      end

      it "should use defaults transforms in none are specified" do
        matrix_transformer = MatrixTransformer.new
        Transform.should_receive(:const_get).with(:LSA).and_return(mock_transform)
        Transform.should_receive(:const_get).with(:TFIDF).and_return(mock_transform)

        matrix_transformer.apply_transforms(mock_vector_space)
      end

      it "should send transform message to class to transform matrix" do
        matrix_transformer = MatrixTransformer.new(:transforms => [:LSA])
        Transform.stub!(:const_get).and_return(mock_transform)

        mock_transform.should_receive(:transform)

        matrix_transformer.apply_transforms(mock_vector_space)
      end

      it "should check that transform class is capable of transforming" do
        matrix_transformer = MatrixTransformer.new(:transforms => [:LSA])
        Transform.stub!(:const_get).and_return(mock_transform)
        mock_transform.should_receive(:respond_to?).with(:transform)

        matrix_transformer.apply_transforms(mock_vector_space)
      end

    end
  end
end
