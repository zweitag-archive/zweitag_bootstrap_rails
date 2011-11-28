$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zweitag_bootstrap_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zweitag_bootstrap_rails"
  s.version     = ZweitagBootstrapRails::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ZweitagBootstrapRails."
  s.description = "TODO: Description of ZweitagBootstrapRails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-test"
end
