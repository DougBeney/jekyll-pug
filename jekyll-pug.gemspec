# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "jekyll-pug"
  gem.version       = "1.5.1"
  gem.date          = "2017-10-30"
  gem.authors       = ["Doug Beney"]
  gem.email         = ["contact@dougie.io"]
  gem.description   = %q{Flawlessly use Pug with Jekyll to convert Pug files into HTML}
  gem.summary       = %q{Use Pug with Jekyll.}
  gem.homepage      = "http://jekyll-pug.dougie.io/"

  gem.files         = ["lib/jekyll-pug.rb", "lib/jekyll-pug/include-tag.rb", "lib/jekyll-pug/pug-renderer.rb"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.license       = "MIT"

  gem.add_runtime_dependency 'jekyll',     '~> 3.3'
  gem.add_runtime_dependency 'pug-ruby',   '~> 2.0'
end
