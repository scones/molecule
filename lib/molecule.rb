require "molecule/railtie"

module Molecule

  class << self
    attr_accessor :stack
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

end

require 'molecule/configuration'
