require File.dirname(__FILE__) + '/../../spec_helper'

module Semantic
  describe Transform::LSA do

    let(:matrix){
      matrix = GSL::Matrix[[0.0, 1.0, 0.0],
                           [1.0, 0.0, 1.0],
                           [0.0, 0.0, 1.0]]

    }

    describe "latent semantic analysis transform" do

      it "should use svd on matrix" do
        u, vt, sigma = matrix.SV_decomp_mod

        matrix.should_receive(:SV_decomp_mod).and_return([u, vt, sigma])

        Transform::LSA.transform!(matrix)
      end

      it "should prevent reducing dimensions greater than the matrixes own dimensions" do
        lambda { Transform::LSA.transform! tiny_matrix, 100 }.should raise_error(Exception)
      end

      it "should transform LSA matrix" do
        transformed_matrix = Transform::LSA.transform! matrix

#        pending("better, less fragile way to compare result matrix.")


        transformed_matrix[0].should be_within(0.1).of(0)
        transformed_matrix[1].should be_within(0.1).of(1.0)
        transformed_matrix[2].should be_within(0.1).of(0)
        transformed_matrix[3].should be_within(0.1).of(0.7)
        transformed_matrix[4].should be_within(0.1).of(0)
        transformed_matrix[5].should be_within(0.1).of(1.1)
        transformed_matrix[6].should be_within(0.1).of(0.4)
        transformed_matrix[7].should be_within(0.1).of(0)
        transformed_matrix[8].should be_within(0.1).of(0.7)
      end

    end

   end
end
