require File.dirname(__FILE__) + '/../spec_helper'

module Semantic
  describe Parser do
    it "should remove stop words based on locale" do
      file = mock "file"
      file.stub!(:read).and_return("un una todo")
      File.stub!(:open).and_yield(file)
      parser = Parser.new 'es'

      parser.remove_stop_words(['hola','una']).should == ['hola']
    end

    it "should remove English stop words by default" do
      file = mock "file"
      file.stub!(:read).and_return("a to be")
      File.stub!(:open).and_yield(file)
      parser = Parser.new(:filter_stop_words => true)

      parser.remove_stop_words(['a','house']).should == ['house']
    end

    it "should remove any non characters" do
      file = mock("file")
      file.stub!(:read).and_return("a to be")
      File.stub!(:open).and_yield(file)

      parser = Parser.new
      parser.tokenise_and_stem("dragon.").should == ["dragon"]
    end

    it "should tokenise the string" do
      parser = Parser.new

      parser.stub!(:remove_stop_words).and_return(['mouse','trap'])
      parser.should_receive(:tokenise_and_stem).and_return(['mouse','trap'])

      parser.tokenise_and_filter(['the mouse trap'])
    end

  end
end
