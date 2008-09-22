require File.dirname(__FILE__) + '/../spec_helper'

describe Semantic::Search do

  documents = ["The cat in the hat disabled", "A cat is a fine pet ponies.", "Dogs and cats make good pets.","I haven't got a hat."]

  def mock_builder
    @builder ||= mock("builder")
  end

  def vector_space
    @vector_space ||= Linalg::DMatrix.rows([[0,1],[1,0]])
  end

  def query_vector
    @query_vector ||= Linalg::DMatrix.rows([[1,0]])
  end

  it "should build the vector space" do
    Semantic::VectorSpace::Builder.stub!(:new).and_return(mock_builder)
    mock_builder.should_receive(:build).with(['test']).and_return(vector_space)

    Semantic::Search.new(['test'])
  end

  describe "searching" do

    it "should map search term to vector space" do
      Semantic::VectorSpace::Builder.stub!(:new).and_return(mock_builder)
      mock_builder.stub!(:build).and_return(vector_space)
      mock_builder.should_receive(:build_query_vector).with("cat").and_return(query_vector)

      vector_search = Semantic::Search.new(documents)
      vector_search.search("cat")
    end

    it "should compare the documents using cosine" do
      pending
    end

  end

  describe "relating" do

    it "should find related documents by comparing cosine" do
      Semantic::VectorSpace::Builder.stub!(:new).and_return(mock_builder)
      mock_builder.stub!(:build).and_return(vector_space)
      
      Semantic::Compare.should_receive(:cosine).with(vector_space.row(0), vector_space.row(0))
      Semantic::Compare.should_receive(:cosine).with(vector_space.row(0), vector_space.row(1))

      vector_search = Semantic::Search.new(documents)
      vector_search.related(0)
    end

  end

end
