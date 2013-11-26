require File.dirname(__FILE__) + '/../../spec_helper'

module Semantic
  describe Transform::TFIDF do

    def matrix(matrix)
      GSL::Matrix[matrix]
    end

    tiny_matrix = GSL::Matrix[[0.0, 1.0, 0.0],
                              [1.0, 0.0, 1.0]]

    describe "term frequency / inverse document frequency transform" do

      it "should find the number of times each term occurs" do
        Transform::TFIDF.should_receive(:number_of_documents_with_term).with(0, GSL::Matrix[[1]]).and_return(2)

        Transform::TFIDF.transform!(GSL::Matrix[[1]])
      end

      it "should ignore counting terms with 0 weighting" do
        Transform::TFIDF.should_not_receive(:number_of_documents_with_term)

        Transform::TFIDF.transform!(GSL::Matrix[[0,0],[0,0]])
      end

      it "should calculate term frequency * inverse document frequency" do
        transformed_matrix = Transform::TFIDF.transform! GSL::Matrix[[1,1],[0,1]]

        transformed_matrix.to_s.should == GSL::Matrix[[1.0, 0],[1.0, 1.0]].to_s
      end

    end
  end
end
