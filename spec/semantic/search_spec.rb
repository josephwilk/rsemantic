require File.dirname(__FILE__) + '/../spec_helper'

describe Semantic::Search do

  documents = ["The cat in the hat disabled", "A cat is a fine pet ponies.", "Dogs and cats make good pets.","I haven't got a hat."]

  def mock_builder
    @builder ||= mock("builder")
  end

  def mock_vector_space
    @vector_space ||= mock("vector space")
    # [Linalg::DMatrix.rows([[1]])]
  end
  
  it "should build the vector space" do
    Semantic::VectorSpace::Builder.stub!(:new).and_return(mock_builder)
    mock_builder.should_receive(:build).with(['test']).and_return(mock_vector_space)

    Semantic::Search.new(['test'])
  end
  
  it "should map search term to vector space" do
    mock_vector_space.stub!(:collect)
    Semantic::VectorSpace::Builder.stub!(:new).and_return(mock_builder)
    mock_builder.stub!(:build).and_return(mock_vector_space)
    mock_builder.should_receive(:build_query_vector).with("cat")
        
    vector_search = Semantic::Search.new(documents)
    vector_search.search("cat")
  end

  it "should compare the documents using cosine" do
    pending
  end
  
  it "should find related documents by comparing cosine" do
    pending
  end
  
end
