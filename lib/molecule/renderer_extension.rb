require 'molecule/renderer'

module Molecule

  module RendererExtension

    def render(context, options)
      if options.key?(:molecule)
        ::Molecule::Renderer.new(@lookup_context, options).render(context)
      else
        super
      end
    end
  end

end
