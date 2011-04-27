$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "semantic/vector_space"
require "semantic/compare"
require "semantic/parser"
require "semantic/matrix_transformer"
require "semantic/search"
require "semantic/transform"
require "semantic/version"

require 'rubygems'
require 'gsl'
# http://rubyforge.org/projects/stemmer/
# A processor for removing the commoner morphological and inflexional endings from words in English
require 'stemmer'
require 'logger'

module Semantic

  class << self
    attr_writer :logger
  end

  def self.logger
    return @logger if @logger
    @logger = Logger.new(STDOUT)
    @logger.formatter = proc { |severity, time, progname, msg| "#{msg}\n" }
    @logger.level = Logger::ERROR
    @logger
  end

end
