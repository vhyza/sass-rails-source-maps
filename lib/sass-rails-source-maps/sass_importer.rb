module SassRailsSourceMaps
  class SassImporter < Sass::Rails::SassImporter

    def public_url(uri, sourcemap_dir = nil)
      source_maps_directory = sourcemap_dir ? sourcemap_dir.sub(Rails.root.join('public').to_s, '') : "/#{SOURCE_MAPS_DIRECTORY}"
      "#{source_maps_directory}/#{File.basename(uri)}"
    end

  end
end
