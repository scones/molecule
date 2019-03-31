module Molecule

  module Helper

    def molecule_inline_style molecule_name
      content_tag(:style, dump_asset(molecule_name, 'inline', 'styles')).html_safe
    end

    def molecule_inline_script molecule_name
      content_tag(:script, dump_asset(molecule_name, 'inline', 'scripts')).html_safe
    end

    def molecule_defer_style molecule_name
      content_tag(:noscript, molecule_inline_style(molecule_name), {class: 'defered-style'}).html_safe
    end

    def molecule_defer_script molecule_name
      content_tag(:script, '', {defer: :defer, src: asset_path(molecule_name, 'defer', 'scripts')}).html_safe
    end


    private


    def dump_asset molecule_name, asset_group, asset_type
      ::File.read(asset_path(molecule_name, asset_group, asset_type)).html_safe
    end

    def asset_path molecule_name, asset_group, asset_type
      config = load_manifest(molecule_name, asset_group, asset_type)
      suffix = suffix_for_type(asset_type)
      asset_slug = "#{molecule_name}-inline.#{suffix}"
      Rails.root.join('public', 'assets', suffix, config[asset_slug])
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
      Rails.root.join('public', 'manifests', "#{molecule_name}-#{asset_group}-#{asset_type}.json")
    end
  end

end
