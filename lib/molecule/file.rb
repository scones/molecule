
module Molecule

  class File

    attr_accessor :name

    def initialize name
      @name = name.to_s
    end

    def read
      JSON.parse(read_file, symbolize_names: true)
    end

    def read_file
      ::File.read(molecule_file_path)
    rescue
      '{}'
    end

    def molecule_file_path
      Rails.root.join('app', 'molecules', @name, 'molecule.json').to_s
    end

  end

end
