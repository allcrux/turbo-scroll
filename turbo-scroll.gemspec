require_relative "lib/turbo-scroll/version"

Gem::Specification.new do |spec|
  spec.name = "turbo-scroll"
  spec.version = TurboScroll::VERSION
  spec.authors = ["Koen handekyn"]
  spec.email = ["koen@handekyn.com"]
  spec.homepage = "https://github.com/allcrux/turbo-scroll"
  spec.summary = "Modern infinite page scrolling for Rails."
  spec.description = "TurboScroll is a minimalistic gem that provides infinite scrolling for Rails based applications using Turbo."
  spec.license = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/allcrux/turbo-scroll"
  spec.metadata["changelog_uri"] = "https://github.com/allcrux/turbo-scroll/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 6"
  spec.add_dependency "turbo-rails", ">= 1"
  spec.add_dependency "view_component", ">= 2"
  spec.add_dependency "slim", ">= 4"
end
