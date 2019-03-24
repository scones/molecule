
module Molecule

  class Stack

    attr_accessor :molecules

    def initialize
      @molecules = []
    end

    def push name
      check_molecule_dependencies if Molecule.config[:verify_children]

      @molecules.push(name)
    end

    def current_molecule
      @molecules.last
    end

    def pop
      @molecules.pop
    end

  end

end
