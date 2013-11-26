require File.dirname(__FILE__) + '/spec_helper'

describe "for a bunch of documents" do
  before(:each) do
    documents = ["The cat in the hat disabled",
                "A cat is a fine pet ponies.",
                "Do and cats make good pets.",
                "I haven't got a cat."]
    @search = RSemantic::Search.new(documents)             
  end

  describe "finding the related document weightings" do
    it "should not contain any NaN" do
      weightings = @search.related(0)

      weightings.each{|weight| weight.should_not be_nan }
    end
  end

end

