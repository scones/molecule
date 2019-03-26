
module Molecule
  class Configuration
    attr_accessor :verify_children

    def initialize
      reset_defaults!
    end

    def reset_defaults!
      @verify_children = false
    end

    def verify_children?
      !!@verify_children
    end

  end
end
