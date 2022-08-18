# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::Update < ViewComponent::Base
  include Turbo::FramesHelper
  include Turbo::StreamsHelper

  attr_reader :page, :infinite_loader_dom_id, :infinite_dom_id, :loading_indicator, :load_on_scroll

  def initialize(page:, infinite_loader_dom_id: :infinite_loader, loading_indicator:, load_on_scroll: true, infinite_dom_id: :infinite)
    @page = page
    @infinite_dom_id = infinite_dom_id
    @loading_indicator = loading_indicator
    @load_on_scroll = load_on_scroll
    @infinite_loader_dom_id = infinite_loader_dom_id
  end
end
