# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::Update < ViewComponent::Base
  include Turbo::FramesHelper
  include Turbo::StreamsHelper

  attr_reader :page
  attr_reader :infinite_dom_id

  def initialize(page:, infinite_dom_id: :infinite)
    @page = page
    @infinite_dom_id = infinite_dom_id
  end
end
