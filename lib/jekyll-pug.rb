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

config_source = ""
if $jekyllConfig['source']
  config_source = $jekyllConfig['source']
end

dir  = Dir.pwd

$JEKYLLPUG_PROJECT_SOURCE_ABS = config_source
$JEKYLLPUG_PROJECT_SOURCE = config_source.sub(/#{dir}/, '')
$JEKYLLPUG_PROJECT_INCLUDES = File.join($JEKYLLPUG_PROJECT_SOURCE, '_includes/.')
  .sub(/^\//, '')
  .sub(/\/\.$/, '')

$PUG_INCLUDES = File.join(config_source, '_includes/.')
