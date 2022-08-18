require "turbo-scroll/version"
require "turbo-scroll/railtie" if defined?(Rails::Railtie)

module TurboScroll
  module ViewHelpers
    #
    def turbo_scroll_auto(page:, loader_dom_id: :loader, loading_indicator: true, id: :infinite, &block)
      safe_concat(%{<div id="#{id}">})
      concat(capture(&block)) if block_given?
      safe_concat("</div>")
      render(TurboScroll::Auto.new(page: page, loader_dom_id: loader_dom_id, loading_indicator: loading_indicator))
    end

    #
    def turbo_scroll_more(page:, loader_dom_id: :loader, id: :infinite, &block)
      safe_concat(%{<div id="#{id}">})
      concat(capture(&block)) if block_given?
      safe_concat("</div>")
      render(TurboScroll::More.new(page: page, loader_dom_id: loader_dom_id))
    end

    #
    def turbo_scroll_more_stream(page:, loader_dom_id: :loader, infinite_dom_id: :infinite, &block)
      render(
        TurboScroll::MoreStream.new(
          page: page,
          loader_dom_id: loader_dom_id,
          infinite_dom_id: infinite_dom_id
        ),
        &block
      )
    end

    #
    def turbo_scroll_auto_stream(page:, loader_dom_id: :loader, infinite_dom_id: :infinite, load_on_scroll: true, loading_indicator: true, &block)
      render(
        TurboScroll::AutoStream.new(
          page: page,
          loader_dom_id: loader_dom_id,
          infinite_dom_id: infinite_dom_id,
          load_on_scroll: load_on_scroll,
          loading_indicator: loading_indicator
        ),
        &block
      )
    end
  end
end
