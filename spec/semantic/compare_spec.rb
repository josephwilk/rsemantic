require File.dirname(__FILE__) + '/../spec_helper'

module Semantic
  describe Compare do

    it "should calculate cosine" do
      cosine =  Compare.cosine(GSL::Matrix[[0.1],[0.5]], GSL::Matrix[[0.9][0.3]])
      cosine.should be_close(0.4961, 0.0001)
    end

  end
end
