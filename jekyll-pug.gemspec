# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "jekyll-pug"
  gem.version       = "0.0.1"
  gem.authors       = ["Doug Beney"]
  gem.email         = ["work@dougbeney.com"]
  gem.description   = %q{Pug to HTML converter for Jekyll}
  gem.summary       = %q{Convert Pug files to standard HTML files as part of your Jekyll build.}
  gem.homepage      = "https://github.com/DougBeney/jekyll-pug"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'jekyll', '>= 3.3.0'
  gem.add_runtime_dependency 'pug-ruby',   '>= 1.0'
end
