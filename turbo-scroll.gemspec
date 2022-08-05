require_relative "lib/turbo-scroll/version"

Gem::Specification.new do |spec|
  spec.name        = "turbo-scroll"
  spec.version     = TurboScroll::VERSION
  spec.authors     = ["Koen handekyn"]
  spec.email       = ["koen@handekyn.com"]
  spec.homepage    = "https://github.com/allcrux/turbo-scroll"
  spec.summary     = "Summary of TurboScroll."
  spec.description = "Description of TurboScroll."
    spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/allcrux/turbo-scroll"
  spec.metadata["changelog_uri"] = "https://github.com/allcrux/turbo-scroll/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.require_paths = ["lib"]

  # spec.add_dependency "rails", ">= 7.0.3.1"
  spec.add_dependency "railties", ">= 6"
  spec.add_dependency "turbo-rails", ">= 1"
  spec.add_dependency "view_component", ">= 2"
  spec.add_dependency "slim", ">= 4"
end
