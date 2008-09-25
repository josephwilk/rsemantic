require File.dirname(__FILE__) + '/../../spec_helper'

describe Semantic::VectorSpace::Builder do

  def mock_transform
    @transform ||= mock(Semantic::Transform)
  end

  def mock_parser
    @parser ||= mock("Parser")
  end

  def documents
    ['nipon','ichiban']
  end

  describe "parsing" do

    it "should tokenise the string documents" do
      mock_parser.stub!(:remove_stop_words).and_return(['mouse','trap'])
      mock_parser.should_receive(:tokenise).and_return(['mouse','trap'])
      Semantic::Parser.stub!(:new).and_return(mock_parser)

      builder = Semantic::VectorSpace::Builder.new
      builder.build(['the mouse trap'])
    end

    it "should remove stopwords for string document" do
      mock_parser.stub!(:tokenise).and_return(['mouse','trap'])
      mock_parser.should_receive(:remove_stop_words).with(['mouse','trap']).and_return(['mouse'])
      Semantic::Parser.stub!(:new).and_return(mock_parser)

      builder = Semantic::VectorSpace::Builder.new
      builder.build(['the mouse trap'])
    end

  end

  describe "transforming matrix" do

    it "should ignore invalid transform class" do
      builder = Semantic::VectorSpace::Builder.new( :transforms => [:FAKE] )
      lambda {
        builder.build(documents)
      }.should_not raise_error
    end

    it "should send transform message to class to transform matrix" do
      builder = Semantic::VectorSpace::Builder.new( :transforms => [:LSA] )
      Semantic::Transform.stub!(:const_get).and_return(mock_transform)

      mock_transform.should_receive(:transform)

      builder.build(documents)
    end

    it "should check that transform class is capable of transforming" do
      builder = Semantic::VectorSpace::Builder.new( :transforms => [:LSA] )
      Semantic::Transform.stub!(:const_get).and_return(mock_transform)

      mock_transform.should_receive(:respond_to?).with(:transform)

      builder.build(documents)
    end

  end

  describe "building query vector" do

    it "should build vector from string" do
      builder = Semantic::VectorSpace::Builder.new
      builder.should_receive(:build_vector_from_string).with("query string")
    
      builder.build_query_vector(["query","string"])
    end

    it "should generate a valid vector" do
      builder = Semantic::VectorSpace::Builder.new
      builder.build(["query string"])
      query = builder.build_query_vector(["query","string"])

      query.should == Linalg::DMatrix.rows([[1,1]])
    end

    it "should generate empty vector when terms are not in document matrix" do
      builder = Semantic::VectorSpace::Builder.new
      builder.build(["string"])
      query = builder.build_query_vector(["not-in-document"])

      query.should == Linalg::DMatrix.rows([[0]])
    end

  end
end
