require File.dirname(__FILE__) + '/../spec_helper'

describe Semantic::MatrixTransformer do

  def mock_transform
    @transform ||= mock(Semantic::Transform)
  end

  matrix = Linalg::DMatrix.rows([[1,0],[0,1]])

  describe "transforming matrix" do

    it "should ignore invalid transform class" do
      matrix_transformer = Semantic::MatrixTransformer.new(:transforms => [:FAKE])
      lambda {
        matrix_transformer.apply_transforms(matrix)
      }.should_not raise_error
    end

    it "should use defaults transforms in none are specified" do
      matrix_transformer = Semantic::MatrixTransformer.new
      Semantic::Transform.should_receive(:const_get).with(:LSA).and_return(mock_transform)
      Semantic::Transform.should_receive(:const_get).with(:TFIDF).and_return(mock_transform)

      matrix_transformer.apply_transforms(matrix)
    end

    it "should send transform message to class to transform matrix" do
      matrix_transformer = Semantic::MatrixTransformer.new(:transforms => [:LSA])
      Semantic::Transform.stub!(:const_get).and_return(mock_transform)

      mock_transform.should_receive(:transform)

      matrix_transformer.apply_transforms(matrix)
    end

    it "should check that transform class is capable of transforming" do
      matrix_transformer = Semantic::MatrixTransformer.new(:transforms => [:LSA])
      Semantic::Transform.stub!(:const_get).and_return(mock_transform)
      mock_transform.should_receive(:respond_to?).with(:transform)

      matrix_transformer.apply_transforms(matrix)
    end

  end
end
