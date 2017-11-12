# # # # # # # # # # # #
# Jekyll-Pug-Renderer #
# # # # # # # # # # # # 

# Simple function= to print data if debug is true.

$jekyll_pug_curFile = ""

def jp(string)
    if $jekyllConfig['jekyll-pug']
        if $jekyllConfig['jekyll-pug']['debug']
            puts "[Jekyll-Pug] " + $jekyll_pug_curFile.to_s + " " + string.to_s
        end
    end
end

def create_cache_and_compile(content, cached_file)
    userSource = $JEKYLLPUG_PROJECT_SOURCE
    pug_raw = content
    content = Pug.compile(content, {"filename"=>userSource})
    ::File.write(cached_file, pug_raw)
    ::File.write(cached_file+".html", content)
    return content
end

def create_cache(content, cached_file)
    ::File.write(cached_file, content)
end

module Jekyll
    class LiquidRenderer
        File.class_eval do
            def parse(content)
                if @filename =~ /\.pug$/
                    filename_regex = /[a-zA-Z1-9\s\~\-\.\_\%\#\&\*\{\}\:\?\+\|\<\>\"\']+.pug/

                    $jekyll_pug_curFile = @filename.match(filename_regex)
                    jp("Processing Pug file.")                    

                    # Creating Cache Variables
                    cache_dir = ".pug-cache/"
                    cached_file = cache_dir + @filename
                    cached_file_dir = cached_file.sub(filename_regex, '')

                    # Creating cache directory neccesary (if needed)
                    FileUtils.mkdir_p(cached_file_dir) unless ::File.exists?(cached_file_dir)

                    # If cached pug file exists
                    if ::File.file?(cached_file)
                        jp("Cached file exists! Attempting to use it...")
                        cached_file_content = ::File.read(cached_file)

                        pugIncludeChange = false
                        # Check if Pug includes have changed.
                        # If Pug includes changed, we must recompile

                        # Loop through Pug includes to determine if any had been modified
                        includes_in_file = content.scan(/^\s+include\s[a-zA-Z1-9\/\_\-\.]+/)
                        for i in includes_in_file do
                        	# Remove spaces/tabs in front of code
                        	include_file = i.sub(/^\s+/, '')
                        	# Remove include statement to be left with filename
                        	include_file = include_file.sub(/include\s/, '')
                        	# If no extension provided, add one
                        	if include_file.scan(/.pug/).length == 0
                        		include_file = include_file + ".pug"
                        	end
                        	jp("Checking the include " + include_file)
                        	# Make the include file into an exact path into the user's project
                        	include_file = $JEKYLLPUG_PROJECT_SOURCE + "/" + include_file
                        	jp("The include file is " + include_file)
                        	# Create the cached location of the include file and its path
                        	include_cache_file = ".pug-cache/" + include_file
                        	include_cache_file_dir = include_cache_file.sub(filename_regex, '')
                        	# Make a cache folder for this include if not already created
                        	FileUtils.mkdir_p(include_cache_file_dir) unless ::File.exists?(include_cache_file_dir)

                        	# Read the file of the include
                        	include_content = ::File.read(include_file)

                        	# If cached version of include exists
                        	if ::File.file?(include_cache_file)
                        		jp("Cached file of include exists. Checking if modified...")
                        		cached_include_content = ::File.read(include_cache_file)
                        		if include_content == cached_include_content
                        			jp("The include is identical to the cache. Not recompiling")
                        		else
                        			jp("There has been a change in an include")
                        			pugIncludeChange = true
                        		end
                        	else
                        		jp("Creating cache file for include...")
                        		pugIncludeChange = true
                        		create_cache(include_content, include_cache_file)
                        	end
                        end

                        # If files are identical
                        if content == cached_file_content and not pugIncludeChange
                            jp("Cached file is identical and includes haven't changed. Using Cached file")
                            # If there is a cached HTML file availible
                            cached_html_filename = cached_file + ".html"
                            if ::File.file?(cached_html_filename)
                                content = ::File.read(cached_html_filename)
                            else
                                jp("Odd. The HTML cached file does not exist. Can't use cache right now. Creating it instead.")
                                content = create_cache_and_compile(content, cached_file)
                            end
                        # If not identical (There has been a change)
                        else
                            jp("There has been a change since last cache. Re-Caching...")
                            content = create_cache_and_compile(content, cached_file)
                        end
                    else
                        jp("No cached file availible. Creating one...")
                        content = create_cache_and_compile(content, cached_file)
                    end

                end
                if content.lines.first =~ /^$/
                content = content.sub(/^$\n/, "")
                end     
                measure_time do
                    @template = Liquid::Template.parse(content, :line_numbers => true)
                end
            end
        end
    end
end

# This section ensures that Pug files are compiled as HTML.
module Jekyll
    class PugConverter < Converter
            safe true
            priority :low

            def matches(ext)
                    ext =~ /^\.pug$/i
            end

            def output_ext(ext)
                    ".html"
            end

            def convert(content)
                    return content
            end
    end
end
