require 'molecule/file'

module Molecule

  class Molecule

    attr_accessor :name, :version, :dependencies
    @@cache = {}

    def initialize name, version, dependencies
      @name = name.to_s
      @version = version
      @dependencies = dependencies
    end

    def has_child? name
      @dependencies.include?(name)
    end

    def self.read name
      read_from_cache(name) || read_from_file(name)
    end

    def self.read_from_file name
      molecule_config = ::Molecule::File.new(name).read

      raise "invalid molecule name '#{name}' in:\n#{molecule_config.inspect}" if name.to_s != molecule_config[:name]

      version = molecule_config[:version] || '0.1.0'
      dependencies = molecule_config[:dependencies] || []

      @@cache[name] = self.new name, version, dependencies
    end

    def self.read_from_cache name
      @@cache[name]
    end

    def self.clear_cache
      @@cache = {}
    end

  end

end
