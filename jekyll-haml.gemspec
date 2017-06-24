# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-haml/version'

Gem::Specification.new do |gem|
  gem.name          = "jekyll-pug"
  gem.version       = Jekyll::Haml::VERSION
  gem.authors       = ["Doug Beney"]
  gem.email         = ["work@dougbeney.com"]
  gem.description   = %q{Pug to html converter for Jekyll}
  gem.summary       = %q{Convert Pug files to standard HTML files as part of your Jekyll build.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'jekyll', '>= 3.3.0'
  gem.add_runtime_dependency 'haml',   '>= 3.0.0'
end
