module RSemantic
  class Corpus
    # @return [Array<Document>]
    attr_reader :documents

    # @param [Array<Document>] documents The {Document documents} to
    #   index
    # @param [Hash] options
    # TODO document options
    def initialize(documents = [], options = {})
      @documents = documents
      @options   = options
      @search    = nil
    end

    # Adds a new {Document document} to the index.
    #
    # @param [Document] document
    # @return [void]
    def add_document(document)
      @documents << document
      document.corpora << self
    end
    alias_method :<<, :add_document

    # Build the index. This is required to be able to search for words
    # or compute related documents.
    #
    # If you add new documents, you have to rebuild the index.
    #
    # @return [void]
    def build_index
      @search = Semantic::Search.new(@documents.map(&:text), @options)
    end

    def search(*words)
      # TODO raise if no index built yet
      results = @search.search(words)
      results.map.with_index { |result, index|
        document = @documents[index]
        Semantic::SearchResult.new(document, result)
      }.sort
    end

    def find_related_document(document)
      @search.related(@documents.index(document)).map.with_index { |result, index|
        document = @documents[index]
        Semantic::SearchResult.new(document, result)
      }.sort
    end

    def find_keywords(document, num = 5)
      # TODO allow limiting keywords to words that occur in this document

    end

    def to_s
      "#<%s %d documents, @options=%s>" % [self.class.name, @documents.size, @options.inspect]
    end
  end
end
