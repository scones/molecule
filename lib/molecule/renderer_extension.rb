require 'molecule/renderer'

module Molecule

  module RendererExtension

    def render(context, options)
#      debugger
      if options.key?(:molecule)
        Molecule::Renderer.new(@lookup_context).render(context, options)
      else
        super
      end
    end
  end

end
