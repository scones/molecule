
module Molecule

  class Stack

    attr_accessor :molecules

    def initialize
      @molecules = []
    end

    def push molecule
      @molecules.push(molecule)
    end

    def current_molecule
      @molecules.last
    end

    def pop
      @molecules.pop
    end

    def empty?
      @molecules.empty?
    end

  end

end
