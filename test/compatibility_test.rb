ENV["RAILS_ENV"] = "test"

gem "view_component", ENV["VIEW_COMPONENT_VERSION"] if ENV["VIEW_COMPONENT_VERSION"]

require "logger"
require "rails"
require "action_controller/railtie"
require "action_view/railtie"
require "turbo-rails"
require "slim-rails"
require "view_component"
require "turbo-scroll"
require "minitest/autorun"

class CompatibilityApplication < Rails::Application
  config.root = File.expand_path("..", __dir__)
  config.eager_load = ENV["EAGER_LOAD"] == "true"
  config.secret_key_base = "turbo-scroll-compatibility-test-secret"
  config.hosts.clear
  config.logger = Logger.new(nil)
  config.view_component.instrumentation_enabled = true

  routes.append do
    get "/items", to: "compatibility#index"
  end
end

CompatibilityApplication.initialize!

class CompatibilityController < ActionController::Base
  TEMPLATES = {
    "auto" => '<%= turbo_scroll_auto(page: @next_page, loader_dom_id: :loader, id: :results) { tag.p("Initial items") } %>',
    "more" => '<%= turbo_scroll_more(page: @next_page, loader_dom_id: :loader, id: :results) { tag.p("Initial items") } %>',
    "auto_stream" => '<%= turbo_scroll_auto_stream(page: @next_page, loader_dom_id: :loader, infinite_dom_id: :results) { tag.p("Next items") } %>',
    "more_stream" => '<%= turbo_scroll_more_stream(page: @next_page, loader_dom_id: :loader, infinite_dom_id: :results) { tag.p("Next items") } %>'
  }.freeze

  def index
    @next_page = params[:last] ? nil : 3
    render inline: TEMPLATES.fetch(params.fetch(:mode, "auto"))
  end
end

class CompatibilityTest < ActionDispatch::IntegrationTest
  def test_preserves_application_component_configuration
    assert_same Rails.application.config.view_component, ViewComponent::Base.config
    assert ViewComponent::Base.config.instrumentation_enabled
  end

  def test_auto_loader_preserves_filters_and_uses_custom_ids
    get "/items", params: {mode: "auto", page: 2, filter: "active", raw: "1"}

    assert_response :success
    assert_select "#results p", text: "Initial items", count: 1
    assert_select "turbo-frame#loader[loading='lazy']" do |elements|
      assert_next_page_url elements.first["src"], format: "turbo_stream"
    end
    assert_select "#loader a" do |elements|
      assert_next_page_url elements.first["href"]
    end
  end

  def test_more_loader_preserves_filters_and_uses_custom_ids
    get "/items", params: {mode: "more", page: 2, filter: "active", raw: "1"}

    assert_response :success
    assert_select "#results p", text: "Initial items", count: 1
    assert_select "turbo-frame#loader a.more" do |elements|
      assert_next_page_url elements.first["href"]
      assert_match %r{/items\.turbo_stream\?}, elements.first["onclick"]
    end
  end

  def test_auto_stream_appends_content_and_replaces_loader
    assert_stream_response "auto_stream", "turbo-frame#loader[loading='lazy']"
  end

  def test_more_stream_appends_content_and_replaces_loader
    assert_stream_response "more_stream", "turbo-frame#loader a.more"
  end

  def test_final_html_page_keeps_content_without_a_loader
    %w[auto more].each do |mode|
      get "/items", params: {mode: mode, last: "1"}

      assert_response :success
      assert_select "#results p", text: "Initial items", count: 1
      assert_select "turbo-frame#loader", count: 0
    end
  end

  def test_final_stream_page_clears_loader
    %w[auto_stream more_stream].each do |mode|
      get "/items.turbo_stream", params: {mode: mode, last: "1"}

      assert_response :success
      assert_select "turbo-stream[action='append'][target='results'] template p", text: "Next items", count: 1
      assert_select "turbo-stream[action='replace'][target='loader'] template" do |elements|
        assert_empty elements.first.inner_html.strip
      end
    end
  end

  private

  def assert_stream_response(mode, loader_selector)
    get "/items.turbo_stream", params: {mode: mode, page: 2, filter: "active", raw: "1"}

    assert_response :success
    assert_equal "text/vnd.turbo-stream.html", response.media_type
    assert_select "turbo-stream[action='append'][target='results'] template p", text: "Next items", count: 1
    assert_select "turbo-stream[action='replace'][target='loader'] template #{loader_selector}", count: 1
  end

  def assert_next_page_url(url, format: "html")
    uri = URI.parse(url)
    assert_equal format == "html" ? "/items" : "/items.turbo_stream", uri.path
    query = Rack::Utils.parse_nested_query(uri.query)
    assert_equal "3", query["page"]
    assert_equal "active", query["filter"]
    refute query.key?("raw")
    refute query.key?("format")
  end
end
