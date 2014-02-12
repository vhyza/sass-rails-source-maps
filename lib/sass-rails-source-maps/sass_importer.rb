require 'sass'

module SassRailsSourceMaps
  # This custom importer adds sprockets dependency tracking on to Sass
  # `@import` statements. This makes the Sprockets and Sass caching
  # systems work together.
  class SassImporter < Sprockets::SassImporter
    attr_accessor :context

    def initialize(root)
      super(nil, root)
    end

    def find_relative(*args)
      engine = super
      if context && engine && (filename = engine.options[:filename])
        context.depend_on(filename)
      end
      engine
    end

    def find(*args)
      engine = super
      if context && engine && (filename = engine.options[:filename])
        context.depend_on(filename)
      end
      engine
    end

    def _dump(level)
      @root
    end

    def self._load(args)
      new(args)
    end

    private

    def evaluate(filename)
      attributes = context.environment.attributes_for(filename)
      processors = context.environment.preprocessors(attributes.content_type) +
        attributes.engines.reverse - [Sprockets::ScssTemplate, Sprockets::SassTemplate, ScssTemplate, SassTemplate]

      context.evaluate(filename, processors: processors)
    end
  end
end
