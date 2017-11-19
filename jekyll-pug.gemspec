# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "jekyll-ghp-deploy"
  gem.version       = "0.0.1"
  gem.date          = "2017-11-19"
  gem.authors       = ["Doug Beney"]
  gem.email         = ["contact@dougie.io"]
  gem.description   = %q{Easily deploy to Github Pages, even if the plugins you use are not whitelisted.}
  gem.summary       = %q{Deploy your build folder to Github pages.}
  gem.homepage      = "https://github.com/DougBeney/jekyll-gbp-deploy"

  gem.files         = ["lib/ghp-deploy.rb"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.license       = "MIT"

  gem.add_runtime_dependency 'jekyll',     '~> 3.3'
end
