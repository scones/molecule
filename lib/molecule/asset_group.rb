
module Molecule

  class AssetGroup
    attr_accessor :name, :type, :file_paths

    def initialize name, type
      @name = name
      @type = type
      @file_paths = []
    end

    def add_file_path file_path
      @file_paths << file_path
    end

  end

end
