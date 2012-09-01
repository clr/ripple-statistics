# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ripple-statistics/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Casey Rosenthal", "Randy Secrist"]
  gem.email         = ["casey@basho.com", "rsecrist@basho.com"]
  gem.description   = %q{Add eventually consistent, distributed statistics to certain document values with minimal changes to existing ripple models.}
  gem.summary       = %q{A simple statistics library for objects stored in riak.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ripple-statistics"
  gem.require_paths = ["lib"]
  gem.version       = Ripple::Statistics::VERSION

  gem.add_dependency 'riak-client'
  gem.add_dependency 'ripple'

  # Test Dependencies
  gem.add_development_dependency 'rake'
end
