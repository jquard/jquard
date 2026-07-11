require_relative "lib/jquard/version"

Gem::Specification.new do |spec|
  spec.name        = "jquard"
  spec.version     = Jquard::VERSION
  spec.authors     = [ "Wieland Pfesdorf" ]
  spec.email       = [ "furrier79eras@icloud.com" ]
  spec.homepage    = "https://github.com/jquard/jquard"
  spec.summary     = "A Filament-inspired admin panel framework for Ruby on Rails."
  spec.description = "Jquard is a mountable Rails engine for building modern admin panels " \
                     "with a chainable resource DSL inspired by Filament (PHP). It generates " \
                     "Filament-style index, create and edit pages from your models, built on " \
                     "Rails defaults: Hotwire, Propshaft and precompiled Tailwind CSS."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jquard/jquard"
  spec.metadata["changelog_uri"] = "https://github.com/jquard/jquard/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  end

  spec.required_ruby_version = ">= 3.2"

  spec.add_dependency "rails", ">= 8.0"
  spec.add_dependency "view_component", "~> 4.0"
end
