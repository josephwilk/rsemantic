$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "rsemantic/vector_space"
require "rsemantic/compare"
require "rsemantic/parser"
require "rsemantic/matrix_transformer"
require "rsemantic/search"
require "rsemantic/transform"
require "rsemantic/version"

require "rsemantic/corpus"
require "rsemantic/document"
require "rsemantic/search_result"

require 'rubygems'
require 'gsl'

require 'stemmer'
require 'logger'

module RSemantic

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
