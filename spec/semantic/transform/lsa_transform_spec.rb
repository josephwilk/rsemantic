require File.dirname(__FILE__) + '/../../spec_helper'

describe Semantic::Transform::LSA do

  large_matrix = Linalg::DMatrix.rows([[0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0],
                                       [0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0],
                                       [1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0],
                                       [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]])

  tiny_matrix = Linalg::DMatrix.rows([[0.0, 1.0, 0.0], 
                                      [1.0, 0.0, 1.0]])

  u = Linalg::DMatrix.rows([[1,0],
                            [0,1]])

  vt = Linalg::DMatrix.rows([[1,0,0],
                             [1,0,0],
                             [1,0,0]])
                             
  sigma = Linalg::DMatrix.rows([[1,0,0],
                                [0,1,0]])

  
  describe "latent semantic analysis transform" do

    it "should use svd on matrix" do
      matrix = Linalg::DMatrix.rows([[0.0, 1.0, 0.0], 
                                     [1.0, 0.0, 1.0]])

      matrix.should_receive(:singular_value_decomposition).and_return([u, sigma, vt])

      Linalg::DMatrix.stub!(:rows).and_return(matrix)

      Semantic::Transform::LSA.transform(matrix)
    end

    it "should reduce the noise in the sigma matrix" do
      matrix = Linalg::DMatrix.rows([[0.0, 1.0, 0.0], 
                                     [1.0, 0.0, 1.0]])

      matrix.stub!(:singular_value_decomposition).and_return([u, sigma, vt])
      Linalg::DMatrix.stub!(:rows).and_return(matrix)

      sigma.should_receive(:[]=).with(0,0,0)
      sigma.should_receive(:[]=).with(1,1,0)
      
      Semantic::Transform::LSA.transform(matrix, 2)
    end

    it "should prevent reducing dimensions greater than the matrixes own dimensions" do
      lambda { Semantic::Transform::LSA.transform tiny_matrix, 100 }.should raise_error(Exception)
    end
    
    it "should transform LSA matrix" do
      transformed_matrix = Semantic::Transform::LSA.transform tiny_matrix

      #TODO: better way to compare result matrix
      transformed_matrix.to_s.should == Linalg::DMatrix.rows([[0,0,0],[1,0,1]]).to_s
    end

  end

end
