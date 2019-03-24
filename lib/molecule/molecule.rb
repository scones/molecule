
module Molecule

  class Molecule

    attr_accessor :name, :version, :dependencies
    @@cache = {}

    def initialize name, version, dependencies
      @name = name
      @version = version
      @dependencies = dependencies
    end

    def self.read name
      read_from_cache(name) || read_from_file(name)
    end

    def self.read_from_file name
      molecule_config = Molecule::File.new(name).read

      raise "invalid molecule name" if name != molecule_config[:name]

      version = molecule_config[:version] || '0.1.0'
      dependencies = molecule_config[:dependencies] || []

      @cache[name] = self.new name, version, dependencies
    end

    def self.read_from_cache
      @cache[name]
    end

    def self.clear_cache
      @cache = {}
    end

  end

end
