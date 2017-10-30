require "pug-ruby"
require "jekyll-pug/pug-renderer"
require "jekyll-pug/include-tag"

# Enable/Disable Minfify based on the user's config file.
if Jekyll.configuration({})['jekyll-pug']
  if Jekyll.configuration({})['jekyll-pug']['minify']
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
