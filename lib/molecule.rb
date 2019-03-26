require "molecule/railtie"

module Molecule

  class << self
    attr_accessor :registry
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

end

require 'molecule/configuration'
