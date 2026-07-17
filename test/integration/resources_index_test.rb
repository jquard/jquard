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

    assert_redirected_to "/admin/comments"
  end

  test "renders the table inside a turbo frame with dsl-defined cells" do
    get "/admin/posts"

    assert_includes response.body, 'id="jquard-table"'
    assert_includes response.body, "jq-badge--success"
    assert_includes response.body, "jq-bool-icon--true"
  end

  test "search filters by searchable columns" do
    get "/admin/posts", params: { q: "Review" }

    assert_includes response.body, "A Post In Review"
    refute_includes response.body, "A Draft Post"
  end

  test "sorting orders records and survives invalid params" do
    get "/admin/posts", params: { sort: "title", direction: "desc" }
    assert_response :success
    assert_operator response.body.index("A Published Post"), :<, response.body.index("A Draft Post")

    get "/admin/posts", params: { sort: "definitely_not_a_column", direction: "sideways", page: "-2" }
    assert_response :success
  end

  test "returns 404 for an unknown resource slug" do
    get "/admin/definitely_not_a_resource"

    assert_response :not_found
  end
end
