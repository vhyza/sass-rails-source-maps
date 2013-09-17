require 'sprockets'
require 'fileutils'
require 'sass-rails-source-maps/version'
require 'sass-rails-source-maps/sass_importer'
require 'sass-rails-source-maps/sass_template'

module SassRailsSourceMaps

  SOURCE_MAPS_DIRECTORY = "assets/source_maps"

end

Sprockets::ScssTemplate.class_eval do
  include SassRailsSourceMaps::SassTemplate
end

Sprockets::SassTemplate.class_eval do
  include SassRailsSourceMaps::SassTemplate
end
