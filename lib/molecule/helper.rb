module Molecule

  module Helper

    def molecule_inline_style molecule_name = default_molecule_name
      content_tag(:style, molecule_asset_contents(molecule_name, 'inline', 'styles')).html_safe
    end

    def molecule_inline_script molecule_name = default_molecule_name
      content_tag(:script, molecule_asset_contents(molecule_name, 'inline', 'scripts')).html_safe
    rescue
      Rails.logger.warn "no inline script for '#{molecule_name}'"
      ''
    end

    def molecule_defer_style molecule_name = default_molecule_name
      relative_link = molecule_relative_path(molecule_name, 'defer', 'styles')
      content_tag(:noscript, class: 'defered-style') do
        content_tag(:link, '', {rel: :stylesheet, type: 'text/css', href: relative_link}).html_safe
      end.html_safe
    end

    def molecule_defer_script molecule_name = default_molecule_name
      relative_link = molecule_relative_path(molecule_name, 'defer', 'scripts')
      content_tag(:script, '', {defer: :defer, src: relative_link}).html_safe
    end

    def molecule_inject_script_name molecule_name = default_molecule_name
      relative_link = molecule_relative_path(molecule_name, 'defer', 'scripts')
      content_tag(:script, "window.script_name='#{relative_link}';".html_safe).html_safe
    rescue
      Rails.logger.warn "no inline script name for '#{molecule_name}'"
      ''
    end

    def molecule_asset_contents molecule_name, asset_group, asset_type
      ::File.read(abolute_asset_path(molecule_name, asset_group, asset_type)).html_safe
    end

    def molecule_relative_path molecule_name, asset_group, asset_type
      suffix, asset = find_asset(molecule_name, asset_group, asset_type)
      "/assets/#{suffix}/#{asset}"
    end

    def molecule_inline_sprite molecule_name
      manifest_path = Rails.root.join('public', 'manifests', "#{molecule_name}/icons.json")

      unless ::File.exists?(manifest_path)
        Rails.logger.warn("asset manifest not found: '#{manifest_path}'")
        return ''
      end

      manifest = ::File.read(manifest_path)
      json = JSON.parse(manifest);
      asset_path = Rails.root.join('public', 'assets', 'svg', json["#{molecule_name}.svg"])
      ::File.read(asset_path).html_safe
    end


    private


    def default_molecule_name
      "#{controller_name}_#{action_name}"
    end

    def find_asset molecule_name, asset_group, asset_type
      config = load_manifest(molecule_name, asset_group, asset_type)
      suffix = suffix_for_type(asset_type)
      asset_slug = "#{molecule_name}-#{asset_type}-#{asset_group}.#{suffix}"
      asset = config[asset_slug]
      return suffix, asset
    end

    def abolute_asset_path molecule_name, asset_group, asset_type
      suffix, asset = find_asset(molecule_name, asset_group, asset_type)
      Rails.root.join('public', 'assets', suffix, asset)
    end

    def suffix_for_type asset_type
      case asset_type
        when 'scripts'
          'js'
        when 'styles'
          'css'
        else
          raise "unknown asset type: #{asset_type}"
      end
    end

    def load_manifest molecule_name, asset_group, asset_type
      manifest = ::File.read(manifest_path(molecule_name, asset_group, asset_type))
      JSON.parse(manifest);
    end

    def manifest_path molecule_name, asset_group, asset_type
      Rails.root.join('public', 'manifests', "#{molecule_name}/#{asset_type}-#{asset_group}.json")
    end
  end

end
