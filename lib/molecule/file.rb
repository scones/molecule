
module Molecule

  class File

    attr_accessor :name

    def initialize name
      @name = name
    end

    def read
      JSON.parse(Molecule::File.new(name), symbolize_names: true)
    end

    def read_file
      File.read(molecule_file_path)
    rescue
      '{}'
    end

    def molecule_file_path
      Rails.root.join('app', 'molecules', @name, 'Moleculefile')
    end

  end

end
