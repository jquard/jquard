require "test_helper"

class ResourcesIndexTest < ActionDispatch::IntegrationTest
  test "lists the records of a registered resource" do
    get "/admin/posts"

    assert_response :success
    assert_includes response.body, "A Draft Post"
    assert_includes response.body, "A Published Post"
  end

  test "returns 404 for an unknown resource slug" do
    get "/admin/definitely_not_a_resource"

    assert_response :not_found
  end
end
