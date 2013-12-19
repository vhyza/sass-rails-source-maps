require 'sprockets'
require 'fileutils'
require 'sass-rails-source-maps/version'
require 'sass-rails-source-maps/sass_importer'
require 'sass-rails-source-maps/sass_template'

module SassRailsSourceMaps

  SOURCE_MAPS_DIRECTORY = "assets/source_maps"

end

Sprockets::ScssTemplate.send(:include, SassRailsSourceMaps::SassTemplate)

Sprockets::SassTemplate.send(:include, SassRailsSourceMaps::SassTemplate)
