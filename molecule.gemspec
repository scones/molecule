$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "molecule/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "molecule"
  spec.version     = Molecule::VERSION
  spec.authors     = ["Dirk Gustke"]
  spec.email       = ["code+molecule@asm68k.org"]
  spec.homepage    = "https://github.com/scones/molecule"
  spec.summary     = "provide and use template and assets in a self-contained way"
  spec.description = "provide and use template and assets in a self-contained way"
  spec.license     = "MIT"

  spec.files = Dir["{bin,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6"

end

