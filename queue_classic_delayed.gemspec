# -*- encoding: utf-8 -*-
require File.expand_path('../lib/queue_classic_delayed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Matt Colyer"]
  gem.email         = ["matt@easel.io"]
  gem.description   = %q{A way to defer queue_classic jobs to the future, the future!}
  gem.summary       = %q{A way to defer queue_classic jobs to the future, the future!}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "queue_classic_delayed"
  gem.require_paths = ["lib"]
  gem.version       = QC::Delayed::VERSION

  gem.add_runtime_dependency "queue_classic", "~> 2.0.1"

  gem.add_development_dependency "bundler", "~> 1.2.0"
  gem.add_development_dependency "rspec", "~> 2.11.0"
end
