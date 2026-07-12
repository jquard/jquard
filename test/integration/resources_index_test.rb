require "test_helper"

class ResourcesIndexTest < ActionDispatch::IntegrationTest
  test "lists the records of a registered resource" do
    get "/admin/posts"

    assert_response :success
    assert_includes response.body, "A Draft Post"
    assert_includes response.body, "A Published Post"
  end

  test "renders the shell with brand name and navigation" do
    get "/admin/posts"

    assert_includes response.body, "Dummy Admin"
    assert_includes response.body, "jq-nav-item--active"
    assert_includes response.body, "--jq-primary-600: #cc342d"
  end

  test "root redirects to the first registered resource" do
    get "/admin"

    assert_redirected_to "/admin/posts"
  end

  test "returns 404 for an unknown resource slug" do
    get "/admin/definitely_not_a_resource"

    assert_response :not_found
  end
end
