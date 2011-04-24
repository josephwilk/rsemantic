require 'stemmer'

module Semantic
  class Parser

    def initialize(locale='en')
      # Based on locale codes
      File.open(File.dirname(__FILE__)+'/../../resources/'+locale+'.stop', 'r') do |file|
        @stopwords = file.read().split()
      end
    end

    def tokenise_and_filter(string)
      word_list = tokenise_and_stem(string)
      remove_stop_words(word_list)
    end

    #remove any nasty grammar tokens from string
    def clean(string)
      string = string.gsub(".","")
      string = string.gsub(/\s+/," ")
      string = string.downcase
      return string
    end

    #stop words are common words which have no search value
    def remove_stop_words(list)
      list.select {|word| word unless @stopwords.include? word }
    end

    def tokenise_and_stem(string)
      string = clean(string)
      words = string.split(" ")

      words.map {|word| word.stem }
    end

  end
end
