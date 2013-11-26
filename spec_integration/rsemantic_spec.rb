require 'spec_helper'

describe "rsemantic" do
  it "should not die" do
    documents = ["The cat in the hat disabled", 
                 "A cat is a fine pet ponies.", 
                 "Do and cats make good pets.",
                 "I haven't got a hat."]

    #Log to stdout how the matrix gets built and transformed
    search = RSemantic::Search.new(documents, :verbose => true)

    #We can pass different transforms to be performed. 
    #Currently only :LSA and :TFIDF. 
    #The order of transforms reflects the order they will be performed on the matrix
    # search = RSemantic::Search.new(documents, :transforms => [:LSA])

    #Defaults to performing :TFIDF and then :LSA
    # search = RSemantic::Search.new(documents)

    #Find documents that are related to documents[0] with a ranking for how related they are.
    puts search.related(0)

    #Search documents for the word cat. 
    #Returns a ranking for how relevant the matches where for each document.
    puts search.search(["cat"])
  end
end