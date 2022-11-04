module TurboScroll
  class Railtie < ::Rails::Railtie
    initializer "turbo-scrolls.load_components" do
      ActiveSupport.on_load(:action_view) do
        require_relative "auto"
        require_relative "auto_stream"
        require_relative "more"
        require_relative "more_stream"
        require_relative "spin_loader"
      end
    end
    initializer "turbo-scrolls.view_helpers" do |app|
      ActiveSupport.on_load(:action_view) do
        include TurboScroll::ViewHelpers
      end
      app.config.i18n.load_path += Dir[File.expand_path(File.join(File.dirname(__FILE__), '../locales', '*.yml')).to_s]
    end
  end
end
