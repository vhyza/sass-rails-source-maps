module SassRailsSourceMaps
  class SassImporter < Sprockets::SassImporter

    def public_url(uri, sourcemap_dir = nil)
      url_root = Rails.configuration.relative_url_root.chomp('/')
      return sourcemap_dir if sourcemap_dir == Rails.root.to_s
      if sourcemap_dir.present?
        target_dir = sourcemap_dir.sub(Rails.root.join('public').to_s, '')
      else
        target_dir = SOURCE_MAPS_DIRECTORY
      end
      "#{url_root}/#{target_dir}/#{File.basename(uri)}"
    end

  end
end
