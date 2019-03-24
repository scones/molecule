
module Molecule
  class Configuration
    attr_accessor :is_gathering
    attr_accessor :is_rendering

    def initialize
      reset_defaults!
    end

    def reset_defaults!
      @is_gathering = false
      @is_rendering = true
    end

    def is_gathering?
      !!@is_gathering
    end

    def is_rendering?
      !!@is_rendering
    end

  end
end
