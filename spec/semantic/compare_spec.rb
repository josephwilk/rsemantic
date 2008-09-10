require File.dirname(__FILE__) + '/../spec_helper'

describe Semantic::Compare do
  
  def vector(values)
    Linalg::DMatrix.rows([values])
  end
  
  it "should calculate cosine" do
    cosine =  Semantic::Compare.cosine( vector([0.1,0.5]), vector([0.9, 0.3]) )
    cosine.should be_close(0.4961, 0.0001)
  end
  
end