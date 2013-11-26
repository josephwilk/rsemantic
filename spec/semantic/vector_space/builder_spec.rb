require File.dirname(__FILE__) + '/../../spec_helper'

module Semantic
  module VectorSpace
    describe Builder do

      def mock_parser
        @parser ||= mock("Parser")
      end

      def documents
        ['nipon','ichiban']
      end

      describe "building query vector" do

        it "should build vector from string" do
          builder = Builder.new
          builder.should_receive(:build_vector).with("query string")

          builder.build_query_vector(["query","string"])
        end

        it "should generate a valid vector" do
          builder = Builder.new
          builder.build_document_matrix(["query string"])
          query = builder.build_query_vector(["query","string"])

          query.should == GSL::Vector[1,1]
        end

        it "should generate empty vector when terms are not in document matrix" do
          builder = Builder.new
          builder.build_document_matrix(["string"])
          query = builder.build_query_vector(["not-in-document"])

          query.should == GSL::Vector[0.0]
        end

      end
    end
  end
end
