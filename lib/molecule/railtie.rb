require 'molecule/controller'
require 'molecule/helper'
require 'molecule/renderer_extension'

module MolecularRenderer

  class Railtie < ::Rails::Railtie

    initializer "molecule.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include Molecule::Helper

        class ::ActionView::Renderer
          prepend Molecule::RendererExtension
        end
      end
    end

  end

end
