require File.dirname(__FILE__) + '/../spec_helper'

module Semantic
  describe Search do

    documents = ["The cat in the hat disabled", "A cat is a fine pet ponies.", "Dogs and cats make good pets.","I haven't got a hat."]

    def mock_builder
      @builder ||= mock(VectorSpace::Builder)
    end

    def mock_matrix_transformer
      @matrix_transformer ||= mock(MatrixTransformer)
    end

    def query_vector
      @query_vector ||= GSL::Matrix[[1,0]]
    end

    def vector_space_model(stubs = {})
      @vector_space_model ||= VectorSpace::Model.new(GSL::Matrix[[0,1],[1,0]], {})
    end

    def matrix(array)
      GSL::Matrix(array)
    end

    def vector(vector)
      matrix([vector])
    end
      
    describe "setting up" do

      it "should build the vector space" do
        VectorSpace::Builder.stub!(:new).and_return(mock_builder)
        mock_builder.should_receive(:build_document_matrix).with(['test']).and_return(vector_space_model)

        Search.new(['test'])
      end

      it "should transform matrices" do
        MatrixTransformer.stub!(:new).and_return(mock_matrix_transformer)
        VectorSpace::Builder.stub!(:new).and_return(mock_builder)
        mock_builder.stub!(:build_document_matrix).and_return(vector_space_model)
        
        #FIXME: with will not match vector_space_model, requests class Data. Think this is related to Delegate and Rspec
        mock_matrix_transformer.should_receive(:apply_transforms).with(anything).and_return(vector_space_model)

        Search.new(['test'])
      end

    end

    describe "searching" do

      it "should map search term to vector space" do
        VectorSpace::Builder.stub!(:new).and_return(mock_builder)
        mock_builder.stub!(:build_document_matrix).and_return(vector_space_model)

        mock_builder.should_receive(:build_query_vector).with("cat").and_return(query_vector)

        vector_search = Search.new(documents)
        vector_search.search("cat")
      end

      it "should compare the documents using cosine" do
        pending
      end

    end

    describe "relating" do

      it "should find related documents by comparing cosine" do
        VectorSpace::Builder.stub!(:new).and_return(mock_builder)
      
        mock_builder.stub!(:build_document_matrix).and_return(vector_space_model)

        MatrixTransformer.stub!(:new).and_return(mock_matrix_transformer)
        mock_matrix_transformer.stub!(:apply_transforms).and_return(vector_space_model)

        Compare.should_receive(:cosine).with(DSL::Matrix[[0],[1]], DSL::Matrix[[0],[1]])
        Compare.should_receive(:cosine).with(DSL::Matrix[[0],[1]], DSL::Matrix[[1],[0]])

        vector_search = Search.new(documents)

        vector_search.related(0)
      end

    end

    describe "logging" do

      before(:each) do
        @out = StringIO.new
        Semantic.logger = Logger.new(@out)
      end

      it "should set info level if in verbose mode" do
        VectorSpace::Builder.stub!(:new).and_return(mock_builder)
        mock_builder.stub!(:build_document_matrix).and_return(vector_space_model)

        Search.new(['test'], :verbose => true)
        
        Semantic.logger.level.should == Logger::INFO
      end
      
      it "should set error level if not in verbose mode" do
        VectorSpace::Builder.stub!(:new).and_return(mock_builder)
        mock_builder.stub!(:build_document_matrix).and_return(vector_space_model)

        Search.new(['test'], :verbose => false)
        
        Semantic.logger.level.should == Logger::ERROR
      end

      it "should default to error level if verbose is not specified" do
        VectorSpace::Builder.stub!(:new).and_return(mock_builder)
        mock_builder.stub!(:build_document_matrix).and_return(vector_space_model)

        Search.new(['test'])
        
        Semantic.logger.level.should == Logger::ERROR
      end

    end

  end
end
