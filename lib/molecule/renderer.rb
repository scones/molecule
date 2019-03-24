
module Molecule

  class Renderer < ::ActionView::PartialRenderer

    # narrow template lookup path to the provided molecule
    def render context, options, &block
      with_member_override(:view_paths, molecule_view_paths(options)) do
        with_member_override(:prefixes, [molecule_prefix(options)]) do
          result = super(context, options, block).body
        end
      end
    end

    # override a member of lookup_context
    def with_member_override member, override, &block
      old_value = @lookup_context.public_send(member)
      molecule_force_set_member(@lookup_context, member, override)
      result = yield
      molecule_force_set_member(@lookup_context, member, old_value)
      result
    end

    def molecule_force_set_member object, member, value
      if object.respond_to?("#{member}=")
        object.public_send("#{member}=", value)
      else
        object.instance_variable_set("@#{member}", value)
      end
    end

    # turn off partial renaming
    def find_template(path, locals)
      prefixes = path.include?(?/) ? [] : @lookup_context.prefixes
      @lookup_context.find_template(path, prefixes, false, locals, @details)
    end

    def molecule_view_paths options
      ::ActionView::PathSet.new([molecule_template_path(options)])
    end

    # molecules path
    def molecule_template_path options
      Rails.root.join('app', 'molecules')
    end

    # path for current molecule
    def molecule_prefix options
      "#{options[:molecule].to_s}/views"
    end

    # default template entrypoint
    def partial_path object = nil, view = nil
      'index'
    end

  end

end
