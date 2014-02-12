require 'sass'

module SassRailsSourceMaps
  class SassCacheStore < ::Sass::CacheStores::Base
    attr_reader :context

    def initialize(context)
      @context = context
    end

    def environment
      context.environment
    end

    def _store(key, version, sha, contents)
      environment.cache_set("sass/#{key}", {:version => version, :sha => sha, :contents => contents})
    end

    def _retrieve(key, version, sha)
      if obj = environment.cache_get("sass/#{key}")
        return unless obj[:version] == version
        return unless obj[:sha] == sha
        obj[:contents]
      else
        nil
      end
    end

    def retrieve(key, sha)
      super.tap do |result|
        if result.respond_to? :context=
          result.context = context
        end
      end
    end

    def path_to(key)
      key
    end
  end
end
