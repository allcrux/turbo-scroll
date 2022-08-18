module TurboScroll
  class Railtie < ::Rails::Railtie
    initializer "turbo-scrolls.load_components" do
      require_relative "update"
      require_relative "loader"
      require_relative "spin_loader"
    end
    initializer "turbo-scrolls.view_helpers" do |app|
      ActiveSupport.on_load(:action_view) do
        include TurboScroll::ViewHelpers
      end
      app.config.i18n.load_path += Dir[File.expand_path(File.join(File.dirname(__FILE__), '../locales', '*.yml')).to_s]
    end
    rake_tasks do
      load "#{Gem.loaded_specs["turbo-scroll"].full_gem_path}/lib/tasks/turbo_scroll_tasks.rake"
    end
  end
end
