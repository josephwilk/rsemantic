$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "rsemantic/version"

Gem::Specification.new do |s|
  s.name             = %q{rsemantic}
  s.version          = RSemantic::VERSION::STRING
  s.platform         = Gem::Platform::RUBY
  s.license          = "MIT"
  s.homepage         = %q{http://github.com/josephwilk/rsemantic}

  s.authors          = ["Joseph Wilk"]

  s.description      = %q{A document vector search with flexible matrix transforms. Currently supports Latent semantic analysis and Term frequency - inverse document frequency}
  s.summary          = %q{A document vector search with flexible matrix transforms. Currently supports Latent semantic analysis and Term frequency - inverse document frequency}
  s.email            = ["joe@josephwilk.net"]
  s.extra_rdoc_files = ["History.txt", "README.md", "TODO.txt"]
  s.files            = Dir.glob("{lib}/**/*") + Dir.glob("{resources}/*")

  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_paths    = ["lib"]

  s.add_runtime_dependency(%q<rb-gsl>)
  s.add_runtime_dependency(%q<fast-stemmer>)
end
