require File.dirname(__FILE__) + '/../../spec_helper'

describe Semantic::Transform::TFIDF do

  def matrix(matrix)
    Linalg::DMatrix.rows(matrix)
  end

  tiny_matrix = Linalg::DMatrix.rows([[0.0, 1.0, 0.0], 
                                      [1.0, 0.0, 1.0]])

  describe "term frequency / inverse document frequency transform" do

    it "should find the number of times each term occurs" do
      Semantic::Transform::TFIDF.should_receive(:get_term_document_occurences).with(0, matrix([[1]])).and_return(2)

      Semantic::Transform::TFIDF.transform(matrix([[1]]))
    end
    
    it "should ignore counting terms with 0 weighting" do
      Semantic::Transform::TFIDF.should_not_receive(:get_term_document_occurences)
      
      Semantic::Transform::TFIDF.transform(matrix([[0,0],[0,0]]))
    end
    
    it "should calculate term frequency" do
      Semantic::Frequency.should_receive(:term_frequency).with(1.0, 3.0).and_return(1.0)
      Semantic::Frequency.should_receive(:term_frequency).with(2.0, 3.0).and_return(1.0)
    
      Semantic::Transform::TFIDF.transform matrix([[1,2]])
    end

    it "should calculate inverse document frequency" do
      Semantic::Frequency.should_receive(:inverse_document_frequency).with(2, 2).twice.and_return(1.0)  
      Semantic::Frequency.should_receive(:inverse_document_frequency).with(2, 1).and_return(1.0)    
            
      Semantic::Transform::TFIDF.transform matrix([[1,0],[1,1]])
    end

  end
end
