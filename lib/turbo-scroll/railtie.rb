module TurboScroll
  class Railtie < ::Rails::Railtie
    initializer "turbo-scrolls.load_components" do
      require_relative "update"
      require_relative "loader"
    end
    initializer "turbo-scrolls.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include TurboScroll::ViewHelpers
      end
    end
  end
end
