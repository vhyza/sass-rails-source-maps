require 'sass-rails-source-maps/sass_cache_store'
require 'sass-rails-source-maps/sass_importer'

module SassRailsSourceMaps
  module MapsHandling

    def write_output(text, destination)
      FileUtils.mkdir_p(Rails.root.join("public", SassRailsSourceMaps::SOURCE_MAPS_DIRECTORY))
      File.open(destination, 'wb') { |file| file.write(text) }
    end

    def copy_dependencies(files)
      files.each do |file|
        FileUtils.cp(file, Rails.root.join("public", SassRailsSourceMaps::SOURCE_MAPS_DIRECTORY, File.basename(file)))
      end
    end

    def evaluate(context, locals, &block)
      cache_store = SassCacheStore.new(context)
      importer = SassImporter.new(context.pathname)
      importer.context = context

      load_paths = context.environment.paths.map do |path|
        SassImporter.new(path).tap do |importer|
          importer.context = context
        end
      end

      options = {
        sourcemap_filename:  ::Sass::Util::sourcemap_name(basename),
        filename:            eval_file,
        line:                line,
        syntax:              syntax,

        cache_store:         cache_store,
        importer:            importer,

        cache:            ::Rails.application.config.assets.debug,

        style:            ::Rails.application.config.sass.style,
        quiet:            ::Rails.application.config.sass.quiet,
        line_numbers:     ::Rails.application.config.sass.line_numbers,
        line_comments:    ::Rails.application.config.sass.line_comments,
        trace_selectors:  ::Rails.application.config.sass.trace_selectors,
        debug_info:       ::Rails.application.config.sass.debug_info,

        load_paths:       load_paths,
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
  end
end
