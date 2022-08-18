# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::Loader < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :page, :infinite_loader_dom_id, :loading_indicator, :load_on_scroll

  def initialize(page:, infinite_loader_dom_id: :infinite_loader, loading_indicator: true, load_on_scroll: true)
    @page = page
    @loading_indicator = loading_indicator
    @infinite_loader_dom_id = infinite_loader_dom_id
    @load_on_scroll = load_on_scroll
  end

  def query_params
    @query_params ||=
      request.query_parameters.except(:page, :raw, :format)
  end

  def next_page_path
    url_for(page: page, **query_params)
  end

  def next_page_stream_path
    url_for(format: :turbo_stream, page: page, **query_params)
  end

  def render?
    page
  end
end
