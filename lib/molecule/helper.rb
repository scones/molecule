
require 'molecule/renderers/base'
require 'molecule/renderer'

module Molecule

  module Helper

    def molecule_inline_asset options
      if !@molecule_registry.nil?
#        raise @molecule_registry.inspect
      end
    end

    def molecule_defer_asset options
      if !@molecule_registry.nil?
      end
    end

    include Molecule::Renderers::Base

  end

end
