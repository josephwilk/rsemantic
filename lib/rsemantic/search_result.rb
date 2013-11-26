module RSemantic
  class SearchResult
    include Comparable

    attr_reader :document
    attr_reader :score
    def initialize(document, score)
      @document = document
      @score    = score
    end

    def <=>(other)
      @score <=> other.score
    end
  end
end
