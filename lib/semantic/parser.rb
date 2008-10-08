require 'stemmer'

module Semantic
  class Parser

    def initialize
      #English stopwords from ftp://ftp.cs.cornell.edu/pub/smart/english.stop

      #TODO: nicer way to reference stop file location?
      File.open(File.dirname(__FILE__)+'/../../resources/english.stop', 'r') do |file|
        @stopwords = file.read().split()
      end
    end

    def tokenise_and_filter(string)
      word_list = tokenise(string)
      remove_stop_words(word_list)
    end

    #remove any nasty grammar tokens from string
    def clean(string)
      string = string.gsub(".","")
      string = string.gsub(/\s+/," ")
      string = string.downcase
      return string
    end

    #Remove common words which have no search value
    def remove_stop_words(list)
      list.select {|word| word unless @stopwords.include? word }
    end

    #break string up into tokens and stem words
    def tokenise(string)
      string = clean(string)
      words = string.split(" ")

      words.map {|word| word.stem }
    end

  end
end
