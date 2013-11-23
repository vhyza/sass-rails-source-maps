module SassRailsSourceMaps
  module SassTemplate

    def write_output(text, destination)
      FileUtils.mkdir_p(Rails.root.join("public", SassRailsSourceMaps::SOURCE_MAPS_DIRECTORY))
      File.open(destination, 'wb') { |file| file.write(text) }
    end

    def copy_dependencies(files)
      files.each do |file|
        FileUtils.cp(file, Rails.root.join("public", SassRailsSourceMaps::SOURCE_MAPS_DIRECTORY, File.basename(file)))
      end
    end

    def evaluate_with_source_maps(context, locals, &block)
      cache_store = Sprockets::SassCacheStore.new(context.environment)

      options = {
        sourcemap_filename:  ::Sass::Util::sourcemap_name(basename),
        filename:            eval_file,
        line:                line,
        syntax:              syntax,
        cache_store:         cache_store,
        cache:               ::Rails.application.config.assets.debug,
        line_numbers:        ::Rails.application.config.sass.line_numbers,
        line_comments:       ::Rails.application.config.sass.line_comments,
        importer:            SassImporter.new(context, context.pathname),
        load_paths:          context.environment.paths.map { |path| SassImporter.new(context, path) },
        sprockets:           {
          context:     context,
          environment: context.environment
        }
      }

      result, mapping = ::Sass::Engine.new(data, options).render_with_sourcemap("/#{SOURCE_MAPS_DIRECTORY}/#{options[:sourcemap_filename]}")

      write_output(data, ::Rails.root.join("public", SOURCE_MAPS_DIRECTORY, basename).to_s)
      write_output(mapping.to_json(
          css_path:       basename.gsub(".#{syntax.to_s}", ""),
          sourcemap_path: ::Rails.root.join("public", SOURCE_MAPS_DIRECTORY, options[:sourcemap_filename])) + "\n",
        ::Rails.root.join("public", SOURCE_MAPS_DIRECTORY, options[:sourcemap_filename]).to_s)
      copy_dependencies(context._dependency_paths)

      result
    rescue ::Sass::SyntaxError => e
      context.__LINE__ = e.sass_backtrace.first[:line]
      raise e
    end

    def self.included(base)
      base.class_eval do
        alias_method_chain :evaluate, :source_maps
      end
    end
  end
end
