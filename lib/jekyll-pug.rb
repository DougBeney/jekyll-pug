require "pug-ruby"
require "jekyll-pug/pug-renderer"
require "jekyll-pug/include-tag"

# Enable/Disable Minfify based on the user's config file.
$jekyllConfig = Jekyll.configuration({})

$CompileFormat = '.html'

if $jekyllConfig['jekyll-pug']
	if $jekyllConfig['jekyll-pug']['minify']
		# Minify is enabled - pretty disabled
		Pug.config.pretty = false
	else
		# Minify is disabled - pretty enabled
		Pug.config.pretty = true
	end
	if $jekyllConfig['jekyll-pug']['php']
		$CompileFormat = '.php'
	end
	if $jekyllConfig['jekyll-pug']['shipped_version']
		# Minify is enabled - pretty disabled
		Pug.use $jekyllConfig['jekyll-pug']['shipped_version']
		puts "Using shipped Pug version: " + Pug.compiler.version.to_s
	else
		# Minify is disabled - pretty enabled
		puts "Using system Pug version: " + Pug.compiler.version.to_s
		Pug.use :system
	end
else
	# Enable pretty by default
	Pug.config.pretty = true
end

# Detect theme/source
jekyll_theme = $jekyllConfig['theme']
jekyll_source = $jekyllConfig['source']

config_source = "" # third condition: no `source:`
if jekyll_theme
	config_source = Jekyll::Theme.new(jekyll_theme).root
elsif jekyll_source
	config_source = jekyll_source
end

dir	 = Dir.pwd

# Theme should use absolute path
$JEKYLLPUG_PROJECT_SOURCE_ABS = config_source
$JEKYLLPUG_PROJECT_SOURCE = jekyll_theme ? config_source : config_source.sub(/#{dir}/, '')
$JEKYLLPUG_PROJECT_INCLUDES = File.join($JEKYLLPUG_PROJECT_SOURCE, '_includes/.')
	.sub(/\/\.$/, '')
$JEKYLLPUG_PROJECT_INCLUDES = $JEKYLLPUG_PROJECT_INCLUDES.sub(/^\//, '') unless jekyll_theme

$PUG_INCLUDES = File.join(config_source, '_includes/.')
