namespace :gemspec do
  desc 'Refresh rsemantic.gemspec to include ALL files'
  task :refresh => 'manifest:refresh' do
    File.open('rsemantic.gemspec', 'w') {|io| io.write($hoe.spec.to_ruby)}
  end
end