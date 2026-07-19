require "test_helper"

class DashboardTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
  end

  test "root serves the dashboard" do
    get "/admin"

    assert_response :success
    assert_select "h1.jq-page-title", text: "Dashboard"
  end

  test "dashboard is reachable by slug" do
    get "/admin/dashboard"

    assert_response :success
    assert_select "h1.jq-page-title", text: "Dashboard"
  end

  test "dashboard appears in the navigation and is active at root" do
    get "/admin"

    assert_select ".jq-nav-item--active", text: /Dashboard/
  end

  test "dashboard is not active when viewing a resource" do
    get "/admin/posts"

    assert_select ".jq-nav-item--active", text: /Posts/
    assert_select ".jq-nav-item--active", text: /Dashboard/, count: 0
  end

  test "page routes do not shadow resource slugs" do
    get "/admin/posts"

    assert_response :success
    assert_includes response.body, "A Draft Post"
  end

  test "unauthenticated visitors cannot reach the dashboard" do
    sign_out users(:admin)

    get "/admin"

    assert_redirected_to "/users/sign_in"
  end
end
