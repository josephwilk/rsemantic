require File.dirname(__FILE__) + '/../../spec_helper'

module Semantic
  describe Transform::LSA do

    let(:matrix){
      matrix = GSL::Matrix[[0.0, 1.0, 0.0],
                           [1.0, 0.0, 1.0],
                           [1.0, 0.0, 1.0]]

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

        #TODO: better way to compare result matrix
        transformed_matrix.to_s.should == "[  -0.000e+00  1.000e+00 -3.331e-16 \n   1.000e+00  1.110e-16  1.000e+00 \n   1.000e+00  2.220e-16  1.000e+00 ]"
      end

    end

  end
end
