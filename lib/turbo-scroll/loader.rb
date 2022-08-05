# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::Loader < ViewComponent::Base
  include Turbo::FramesHelper

  attr_reader :page

  def initialize(page:)
    @page = page
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

