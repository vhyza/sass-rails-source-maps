require 'sprockets'
require 'sass-rails'
require 'fileutils'
require 'sass-rails-source-maps/version'
require 'sass-rails-source-maps/sass_importer'
require 'sass-rails-source-maps/sass_template'

module SassRailsSourceMaps

  SOURCE_MAPS_DIRECTORY = "assets/source_maps"

end

Sass::Rails::ScssTemplate.send(:include, SassRailsSourceMaps::SassTemplate)

Sass::Rails::SassTemplate.send(:include, SassRailsSourceMaps::SassTemplate)
