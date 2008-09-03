require 'rubygems'
gem 'rspec'
require 'spec'

$:.unshift(File.join(File.dirname(__FILE__), %w[.. lib]))

require 'frequency'
require 'lsa'