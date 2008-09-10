require File.dirname(__FILE__) + '/../spec_helper'

describe Semantic::Parser do

  it "should remove stop words" do
    file = mock("file")
    file.stub!(:read).and_return("a to be")
    File.stub!(:open).and_yield(file)
    parser = Semantic::Parser.new

    parser.remove_stop_words(['a','house']).should == ['house']
  end
  
  it "should remove any non characters" do
    file = mock("file")
    file.stub!(:read).and_return("a to be")
    File.stub!(:open).and_yield(file)
        
    parser = Semantic::Parser.new
    parser.tokenise("dragon.").should == ["dragon"]
  end

end
