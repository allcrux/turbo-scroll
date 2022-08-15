# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::Update < ViewComponent::Base
  include Turbo::FramesHelper
  include Turbo::StreamsHelper

  attr_reader :page, :infinite_dom_id, :loading_indicator

  def initialize(page:, loading_indicator:, infinite_dom_id: :infinite)
    @page = page
    @infinite_dom_id = infinite_dom_id
    @loading_indicator = loading_indicator
  end
end
