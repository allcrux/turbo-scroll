require "turbo-scroll/version"
require "turbo-scroll/railtie" if defined?(Rails::Railtie)

module TurboScroll
  module ViewHelpers
    def turbo_scroll_loader(page:, infinite_loader_dom_id: :infinite_loader, loading_indicator: true, load_on_scroll: true)
      render(TurboScroll::Loader.new(page: page, infinite_loader_dom_id: infinite_loader_dom_id, loading_indicator: loading_indicator, load_on_scroll: load_on_scroll))
    end

    def turbo_scroll_update(page:, infinite_loader_dom_id: :infinite_loader, infinite_dom_id: :infinite, load_on_scroll: true, loading_indicator: true, &block)
      render(
        TurboScroll::Update.new(
          page: page,
          infinite_loader_dom_id: infinite_loader_dom_id,
          infinite_dom_id: infinite_dom_id,
          load_on_scroll: load_on_scroll,
          loading_indicator: loading_indicator
        ),
        &block
      )
    end
  end
end
