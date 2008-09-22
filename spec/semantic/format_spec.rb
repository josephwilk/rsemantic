require File.dirname(__FILE__) + '/../spec_helper'

describe Semantic::Format do
  
  it "should output a DMatrix as a pretty string" do
    out = Semantic::Format::pretty_print(Linalg::DMatrix.rows([[0.11111,0.66666],[0.33333, 0.001]]))
    
    out.should == "[ +0.11 +0.67 ]\n[ +0.33 +0.00 ]\n"
  end
  
end
