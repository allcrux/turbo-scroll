# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::MoreStream < ViewComponent::Base
  include Turbo::FramesHelper
  include Turbo::StreamsHelper

  attr_reader :page, :loader_dom_id, :infinite_dom_id

  def initialize(page:, loader_dom_id: :turbo_loader, infinite_dom_id: :infinite)
    @page = page
    @loader_dom_id = loader_dom_id
    @infinite_dom_id = infinite_dom_id
  end
end
