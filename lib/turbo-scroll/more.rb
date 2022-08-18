# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::More < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :page, :loader_dom_id

  def initialize(page:, loader_dom_id: :loader)
    @page = page
    @loader_dom_id = loader_dom_id
  end

  def query_params
    @query_params ||=
      request.query_parameters.except(:page, :raw, :format)
  end

  def next_page_stream_path
    url_for(format: :turbo_stream, page: page, **query_params)
  end

  def render?
    page
  end
end
