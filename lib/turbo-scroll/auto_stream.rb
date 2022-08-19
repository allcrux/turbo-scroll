# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::AutoStream < ViewComponent::Base
  include Turbo::FramesHelper
  include Turbo::StreamsHelper

  attr_reader :page, :loader_dom_id, :infinite_dom_id, :loading_indicator

  def initialize(page:, loader_dom_id: :loader, loading_indicator:, infinite_dom_id: :infinite)
    @page = page
    @infinite_dom_id = infinite_dom_id
    @loading_indicator = loading_indicator
    @loader_dom_id = loader_dom_id
  end
end
