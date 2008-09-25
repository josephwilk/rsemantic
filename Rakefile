begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'spec'
end
begin
  require 'spec/rake/spectask'
rescue LoadError
  puts <<-EOS
  To use rspec for testing you must install rspec gem:
  gem install rspec
  EOS
  exit(0)
end

require 'rake'
require 'spec/rake/verify_rcov'

desc "Run the specs under spec/models"
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['--options', "spec/spec.opts"]
  t.spec_files = FileList['spec/**/*_spec.rb']

  unless ENV['NO_RCOV']
    t.rcov = true
    t.rcov_dir = 'coverage'
    t.rcov_opts = ['--exclude', '_helper\.rb,_spec\.rb,spec\/boss,\/var\/lib\/gems,\/Library\/Ruby,\.autotest']
  end
end

RCov::VerifyTask.new(:verify_rcov => :spec) do |t|
  t.threshold = 99.7 # Make sure you have rcov 0.9 or higher!
  t.index_html = 'coverage/index.html'
end

namespace :example do

  require 'lib/semantic'

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
