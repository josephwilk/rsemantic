require 'lib/semantic'

namespace :example do

  documents = ["The cat in the hat disabled", "A cat is a fine pet ponies.", "Dogs and cats make good pets.","I haven't got a hat."]

  desc "run main LSA example"
  task :lsa do
    search = Semantic::Search.new(documents, :verbose => true)
  end

  desc "run main Vector space example"
  task :vector_space do
    search = Semantic::Search.new(documents)

    puts "Documents:"
    documents.each_with_index { |document, index| puts "#{index}: #{document}"  }
    puts

    puts "Documents related to first document: #{documents[0]}"
    puts search.related(0)
    puts

    puts "Searching for the word cat:"
    puts search.search(["cat"])
    puts
  end

end
