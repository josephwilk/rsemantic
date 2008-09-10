module Semantic
  class Search

    def initialize(documents)
      @search_engine = VectorSpace.new(documents)
    end
    
    #Find documents that are related to the document indexed by passed Id within the document Vectors"""
    def related(documentId)
      rankings = @search_engine.search(documentId)
    end

    #Search for documents that match based on a list of terms """
    def search(searchList)
      rankings = @search_engine.search(searchList)
    end
        
  end
end