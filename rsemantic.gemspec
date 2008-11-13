Gem::Specification.new do |s|
  s.name = %q{semantic}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joseph Wilk"]
  s.date = %q{2008-11-13}
  s.description = %q{A document vector search with flexible matrix transforms. Currently supports Latent semantic analysis and Term frequency - inverse document frequency}
  s.email = ["josephwilk@joesniff.co.uk"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "TODO.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "TODO.txt", "config/hoe.rb", "config/requirements.rb", "gem_tasks/deployment.rake", "gem_tasks/environment.rake", "gem_tasks/examples.rake", "gem_tasks/fix_cr_lf.rake", "gem_tasks/gemspec.rake", "gem_tasks/rspec.rake", "gem_tasks/website.rake", "lib/semantic.rb", "lib/semantic/compare.rb", "lib/semantic/matrix_transformer.rb", "lib/semantic/parser.rb", "lib/semantic/search.rb", "lib/semantic/transform.rb", "lib/semantic/transform/lsa_transform.rb", "lib/semantic/transform/tf_idf_transform.rb", "lib/semantic/vector_space.rb", "lib/semantic/vector_space/builder.rb", "lib/semantic/vector_space/model.rb", "lib/semantic/version.rb", "resources/english.stop", "rsemantic.gemspec", "spec/semantic/compare_spec.rb", "spec/semantic/matrix_transformer_spec.rb", "spec/semantic/parser_spec.rb", "spec/semantic/search_spec.rb", "spec/semantic/transform/lsa_transform_spec.rb", "spec/semantic/transform/tf_idf_transform_spec.rb", "spec/semantic/vector_space/builder_spec.rb", "spec/semantic/vector_space/model_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/josephwilk/rsemantic}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rsemantic}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A document vector search with flexible matrix transforms. Currently supports Latent semantic analysis and Term frequency - inverse document frequency}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 1.0.3"])
      s.add_runtime_dependency(%q<rspec>, [">= 1.1.5"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 1.1.2"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.3"])
      s.add_dependency(%q<rspec>, [">= 1.1.5"])
      s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.3"])
    s.add_dependency(%q<rspec>, [">= 1.1.5"])
    s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end
