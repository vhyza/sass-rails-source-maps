module SassRailsSourceMaps
  class SassImporter < Sprockets::SassImporter

    def public_url(uri)
      "/#{SOURCE_MAPS_DIRECTORY}/#{File.basename(uri)}"
    end

  end
end
