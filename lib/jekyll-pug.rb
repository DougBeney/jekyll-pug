require "pug-ruby"
require "jekyll-pug/pug-renderer"
require "jekyll-pug/include-tag"

# Enable/Disable Minfify based on the user's config file.
$jekyllConfig = Jekyll.configuration({})

if $jekyllConfig['jekyll-pug']
  if $jekyllConfig['jekyll-pug']['minify']
    # Minify is enabled - pretty disabled
    Pug.config.pretty = false
  else
    # Minify is disabled - pretty enabled
    Pug.config.pretty = true
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