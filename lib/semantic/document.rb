module Semantic
  class Document
    attr_reader :text
    attr_reader :attributes
    attr_reader :corpora
    def initialize(text, attributes = {})
      if text.respond_to?(:read)
        @text = text.read
      else
        @text = text
      end

      @attributes = attributes
      @corpora    = []
    end

    def to_s
      "#<%s @attributes=%s>" % [self.class.name, @attributes.inspect]
    end

    def [](key)
      @attributes[key]
    end

    # @todo document that it has to be part of at least one corpus
    def related
      results = {}
      @corpora.each do |corpus|
        results[corpus] = corpus.find_related_document(self)
      end

      results
    end

    def keywords(num = 5)

    end
  end
end
