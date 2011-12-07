$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zweitag_bootstrap_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zweitag_bootstrap_rails"
  s.version     = ZweitagBootstrapRails::VERSION
  s.authors     = ["Heiko Zeus"]
  s.email       = ["heiko.zeus@zweitag.de"]
  s.homepage    = "https://github.com/zweitag/zweitag_bootstrap_rails"
  s.summary     = "Simplifies the generation of markup for twitter bootstrap with rails"
  s.description = "Adds some methods to generate suitable markup for twitter bootstrap, adjusts SimpleForm and WillPaginate"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-test"
end
