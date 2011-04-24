require 'rubygems'
gem 'rspec'
#require 'spec' # this fails on ruby 1.8.7 (2010-04-19 patchlevel 253) [i686-linux], MBARI 0x8770, Ruby Enterprise Edition 2010.02

$:.unshift(File.join(File.dirname(__FILE__), %w[.. lib]))

require 'semantic'
