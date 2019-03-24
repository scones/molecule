require 'molecule/asset_group'
require 'json'

module Molecule

  class Registry

    attr_accessor :name, :molecules

    def initialize name
      @name = name
      @molecules = {}
    end

    def register_molecule molecule_name
      @molecules[molecule_name] = 1
      nil
    end

    def dump_molecule_file
      molecule = read_molecule_file || {}
      molecule[:dependencies] = @molecules.keys
      File.open(registry_file_path, 'w') do |file|
        file.write(molecule_structure.to_json)
      end
    end

    def read_molecule_file
      JSON.parse(open_molecule_file, symbolize_names: true)
    end

    def open_molecule_file
      File.read(registry_file_path)
    rescue
      '{}'
    end

    def registry_file_path
      Rails.root.join('app', 'molecules', @name, 'Moleculefile')
    end

    def molecule_structure
      {
        dependencies: @molecules.keys.to_json
      }
    end

  end

end
