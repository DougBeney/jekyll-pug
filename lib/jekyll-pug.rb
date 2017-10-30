require "pug-ruby"
require "jekyll-pug/pug-renderer"
require "jekyll-pug/include-tag"

# Enable/Disable Minfify based on the user's config file.
jekyllConfig = Jekyll.configuration({})

if jekyllConfig['jekyll-pug']
  if jekyllConfig['jekyll-pug']['minify']
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
if jekyllConfig['source']
  config_source = jekyllConfig['source']
end

$JEKYLLPUG_PROJECT_SOURCE = File.join(config_source, '_includes/.')
