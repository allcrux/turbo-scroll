namespace :turbo_scroll do
  task :generate_turbo_controller do
    source = File.join(Gem.loaded_specs["turbo-scroll"].full_gem_path, "lib", "javascript", "controllers", "turbo_controller.js")
    target = File.join(Rails.root, "app", "javascript", "controllers", "turbo_controller.js")
    FileUtils.cp_r source, target
  end
end
