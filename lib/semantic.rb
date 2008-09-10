$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "semantic/vector_space"

require 'semantic/lsa'
require 'semantic/frequency'
require "semantic/compare"
require "semantic/parser"
require "semantic/search"



require 'rubygems'
#http://tartarus.org/~martin/PorterStemmer/python.txt
#A processor for removing the commoner morphological and inflexional endings from words in English
require 'linalg'