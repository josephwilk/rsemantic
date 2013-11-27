require File.dirname(__FILE__) + '/../../spec_helper'

module Semantic
  module VectorSpace

    describe Model do

      it "should output a DMatrix as a pretty string" do
        model = Model.new(GSL::Matrix[[0.11111, 0.33333],[0.66666, 0.001]], {})
        
        model.to_s.should include("[ +0.11 +0.33 ]\n[ +0.67 +0.00 ]\n")
      end
      
      it "should output keywords for the matrix rows" do
        model = Model.new(GSL::Matrix[[0]], {'shiva' => 0})

        model.to_s.should include("shiva     [ +0.00 ]")
      end

    end
  end
end
