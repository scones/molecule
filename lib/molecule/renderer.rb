require 'molecule/molecule'
require 'molecule/stack'

module Molecule

  class Renderer < ::ActionView::PartialRenderer

    # narrow template lookup path to the provided molecule
    def render context, &block
      @@stack ||= ::Molecule::Stack.new
      with_member_override(:view_paths, molecule_view_paths) do
        with_member_override(:prefixes, [molecule_prefix]) do
          with_dependency_check(@options[:molecule]) do
            with_new_molecule(@options[:molecule]) do
              result = super(@options[:molecule], context, block).body
            end
          end
        end
      end
    end

    # override a member of lookup_context
    def with_member_override member, override, &block
      old_value = @lookup_context.public_send(member)
      molecule_force_set_member(@lookup_context, member, override)
      yield
    ensure
      molecule_force_set_member(@lookup_context, member, old_value)
    end

    def with_dependency_check name, &block
      if !@@stack.empty? && ::Molecule.config.verify_children?
        unless @@stack.current_molecule.has_child?(name.to_s)
          raise "requested molecule (#{name}) is not configured as a child of current molecule (#{@@stack.current_molecule.name})"
        end
      end
      yield
    end

    def with_new_molecule name
      @@stack.push(::Molecule::Molecule.read(name))
      yield
    ensure
      @@stack.pop
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

    def molecule_view_paths
      ::ActionView::PathSet.new([molecule_template_path])
    end

    # molecules path
    def molecule_template_path
      Rails.root.join('app', 'molecules')
    end

    # path for current molecule
    def molecule_prefix
      "#{@options[:molecule].to_s}/views"
    end

    # default template entrypoint
    def partial_path object = nil, view = nil
      'index'
    end

  end

end

