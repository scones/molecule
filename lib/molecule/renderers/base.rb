
module Molecule

  module Renderers

    module Base

      def molecule_inline_asset options
        raise options.inspect
      end

      def molecule_render name, options
        Molecule.registry.verify_child if options[:verify_chilren]

        render file: molecule_path(name).join('views', name)
      end

      def molecule_path name
        Rails.root.join('app', 'molecules', name)
      end

    end

  end

end
