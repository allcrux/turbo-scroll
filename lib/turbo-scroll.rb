require "turbo-scroll/version"
require "turbo-scroll/railtie" if defined?(Rails::Railtie)

module TurboScroll
  module ViewHelpers
    def turbo_scroll_loader(page:, loading_indicator: true)
      render(TurboScroll::Loader.new(page: page, loading_indicator: loading_indicator))
    end

    def turbo_scroll_update(page:, infinite_dom_id: :infinite, loading_indicator: true, &block)
      render(
        TurboScroll::Update.new(
          page: page,
          infinite_dom_id: infinite_dom_id,
          loading_indicator: loading_indicator
        ),
        &block
      )
    end
  end
end
