require 'pug-ruby'

module Jekyll
  module Tags
    class JekyllPug_IncludeTag  < IncludeTag
      def initialize(tag_name, markup, tokens)
        super
        matched = markup.strip.match(VARIABLE_SYNTAX)
        if matched
          @file = matched["variable"].strip
          @params = matched["params"].strip
        else
          @file, @params = markup.strip.split(%r!\s+!, 2)
        end
        # If file does not have an extension...
        if @file !~ /\.\w+$/
          # ...add a .pug
          # "navigation" -> "navigation.pug"
          @file = @file + ".pug"
          @isPug = true
        else
          @isPug = false
        end
        validate_params if @params
        @tag_name = tag_name
      end
      # Render the variable if required
      def render_variable(context)
        if @file.match(VARIABLE_SYNTAX)
          partial = context.registers[:site]
            .liquid_renderer
            .file("(variable)")
            .parse(@file)
          partial.render!(context)
        end
      end

      def locate_include_file(context, file, safe)
        includes_dirs = tag_includes_dirs(context)
        includes_dirs.each do |dir|
          path = File.join(dir.to_s, file.to_s)
          return path if valid_include_file?(path, dir.to_s, safe)
        end
        raise IOError, "Could not locate the included file '#{file}' in any of "\
          "#{includes_dirs}. Ensure it exists in one of those directories and, "\
          "if it is a symlink, does not point outside your site source."
      end

      def render(context)
        site = context.registers[:site]
        file = render_variable(context) || @file
        validate_file_name(file)

        path = locate_include_file(context, file, site.safe)
        return unless path


        add_include_to_dependency(site, path, context)

        partial = load_cached_partial(path, context)
        context.stack do
          context["include"] = parse_params(context) if @params
          begin
            partial.render!(context)
          rescue Liquid::Error => e
            e.template_name = path
            e.markup_context = "included " if e.markup_context.nil?
            raise e
          end
        end
      end
    end

    class JekyllPug_IncludeRelativeTag < IncludeTag
      def tag_includes_dirs(context)
        Array(page_path(context)).freeze
      end

      def page_path(context)
        if context.registers[:page].nil?
          context.registers[:site].source
        else
          current_doc_dir = File.dirname(context.registers[:page]["path"])
          context.registers[:site].in_source_dir current_doc_dir
        end
      end
    end
  end
end

Liquid::Template.register_tag("include", Jekyll::Tags::JekyllPug_IncludeTag)
Liquid::Template.register_tag("include_relative", Jekyll::Tags::JekyllPug_IncludeRelativeTag)
