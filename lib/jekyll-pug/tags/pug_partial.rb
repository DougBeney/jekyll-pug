require 'pug-ruby'
require 'open3'

module Jekyll
    class PugPartialTag < Liquid::Tag
        isHTML = false

        def initialize(tag_name, file, tokens)
            super
            @file = file.strip
        end

        def render(context)
            includes_dir = File.join(context.registers[:site].source, '_includes')

            if File.symlink?(includes_dir)
                return "Includes directory '#{includes_dir}' cannot be a symlink"
            end

            if @file !~ /^[a-zA-Z0-9_\/\.-]+$/ || @file =~ /\.\// || @file =~ /\/\./
                return "Include file '#{@file}' contains invalid characters or sequences"
            end

            if @file !~ /\.html$/
                isHTML = false
            else
                isHTML = true
            end

            if @file !~ /\.pug$/
                if !isHTML
                    @file << ".pug"
                end
            end

            Dir.chdir(includes_dir) do
                choices = Dir['**/*'].reject { |x| File.symlink?(x) }
                if choices.include?(@file)
                    source     = File.read(@file)
                    if !isHTML
                        conversion = Pug.compile(source, {"filename" => includes_dir + "/."})
                    else
                        conversion = source
                    end
                    partial    = Liquid::Template.parse(conversion)
                    begin
                    return partial.render!(context)
                rescue => e
                    puts "Liquid Exception: #{e.message} in #{data['layout']}"
                    e.backtrace.each do |backtrace|
                        puts backtrace
                    end
                    abort('Build Failed')
                end

                    context.stack do
                        return partial.render(context)
                    end
                else
                    "Included file '#{@file}' not found in _includes directory"
                end
            end
            end
    end
end

Liquid::Template.register_tag('include', Jekyll::PugPartialTag)
