require 'molecule/renderer'

module Molecule

  module RendererExtension

    def render(context, options)
      if options.key?(:molecule)
        options[:molecule] = options[:molecule].to_s
        ::Molecule::Renderer.new(@lookup_context, options).render(context)
      else
        super
      end
    end
  end

end
