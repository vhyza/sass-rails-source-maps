require 'sprockets'
require 'sass-rails-source-maps/sass_template'
require 'sass-rails-source-maps/scss_template'

module SassRailsSourceMaps
  SOURCE_MAPS_DIRECTORY = "assets/source_maps"
end

#XXX This should go into a class method or something - ideally, the config
#should be as Sprockets recommends:
#  config.assets.configure do |env|
#    env.register_engine ".sass" SassRailsSourceMaps::SassTemplate
#  end
#
Sprockets.register_engine ".sass", SassRailsSourceMaps::SassTemplate
Sprockets.register_engine ".scss", SassRailsSourceMaps::ScssTemplate
