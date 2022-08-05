require "turbo-scroll/version"
require "turbo-scroll/railtie" if defined?(Rails::Railtie)

module TurboScroll
  module ViewHelpers
    def turbo_scroll_loader(page:)
      render(TurboScroll::Loader.new(page: page))
    end

    def turbo_scroll_update(page:, infinite_dom_id: :infinite, &block)
      render(TurboScroll::Update.new(page: page, infinite_dom_id: infinite_dom_id), &block)
    end
  end
end
