# frozen_string_literal: true

require "turbo-rails"

class TurboScroll::SpinLoader < ViewComponent::Base
  attr_reader :loading_indicator

  def initialize(loading_indicator: true)
    @loading_indicator = loading_indicator
  end

  def render?
    loading_indicator
  end
end
