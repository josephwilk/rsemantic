#http://rubyforge.org/projects/stemmer/
require 'rubygems'
require 'stemmer'
require 'linalg'

require File.dirname(__FILE__) + "/compare"
require File.dirname(__FILE__) + "/parser"

module Semantic

  class Search

    def initialize(documents)
      @builder = VectorSpace::Builder.new
      @document_vectors = @builder.build(documents)
    end
  
    def related(documentId)
      ratings = @document_vectors.collect {|document_vector| Compare.cosine(@document_vectors[documentId], document_vector) }
    end

    def search(searchList)
      queryVector = @builder.build_query_vector(searchList)
      ratings = @document_vectors.collect {|document_vector| Compare.cosine(queryVector, document_vector)}
    end

  class << self
    def main
      #test data
      documents = ["The cat in the hat disabled", "A cat is a fine pet ponies.", "Dogs and cats make good pets.","I haven't got a hat."]

      vector_space = Search.new(documents)
  
      puts vector_space.related(0)
      puts vector_space.search(["cat"])
    end
  end
end
end
# Semantic::main