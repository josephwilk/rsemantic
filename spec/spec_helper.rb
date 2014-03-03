require 'bundler'
Bundler.require(:default, :test)

require 'limited_red'
#require 'limited_red/plugins/rspec'

$:.unshift(File.join(File.dirname(__FILE__), %w[.. lib]))

