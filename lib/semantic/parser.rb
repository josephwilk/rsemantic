require 'stemmer'
require "set"
module Semantic
  class Parser

    def initialize(options = {})
      # English stopwords from ftp://ftp.cs.cornell.edu/pub/smart/english.stop
      # TODO: nicer way to reference stop file location?
      @filter_stop_words = options[:filter_stop_words]
      @stem_words        = options[:stem_words]
      if @filter_stop_words
        File.open(File.dirname(__FILE__) + '/../../resources/english.stop', 'r') do |file|
          @stopwords = Set.new(file.read().split())
        end
      end
    end

    def tokenise_and_filter(string)
      word_list = tokenise_and_stem(string)
      remove_stop_words(word_list)
    end

    # remove any nasty grammar tokens from string
    def clean(string)
      string = string.gsub(".","")
      string = string.gsub(/\s+/," ")
      string = string.downcase
      return string
    end

    # stop words are common words which have no search value
    def remove_stop_words(list)
      if @filter_stop_words
        list.select {|word| !@stopwords.include?(word) }
      else
        list
      end
    end

    def tokenise_and_stem(string)
      string = clean(string)
      words = string.split(" ")

      if @stem_words
        words.map {|word| Stemmer.stem_word(word) }
      else
        words
      end
    end

  end
end
