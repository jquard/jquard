require "test_helper"

class ResourcesCrudTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
  end

  test "create page renders the dsl-defined form" do
    get "/admin/posts/create"

    assert_response :success
    assert_includes response.body, "Create post"
    assert_select ".jq-breadcrumbs span", text: "Create"
    assert_includes response.body, "jq-section"
    assert_includes response.body, 'name="post[title]"'
    assert_includes response.body, 'name="post[status]"'
    assert_includes response.body, "Leave empty for unpublished posts"
  end

  test "creating a valid record redirects to its edit page with a toast" do
    assert_difference -> { Post.count }, 1 do
      post "/admin/posts", params: { post: { title: "Brand new", status: "draft" } }
    end

    record = Post.order(:id).last
    assert_redirected_to "/admin/posts/#{record.id}/edit"
    follow_redirect!
    assert_includes response.body, "Post created"
    assert_includes response.body, "jq-toast"
  end

  test "creating an invalid record re-renders with errors and preserved input" do
    assert_no_difference -> { Post.count } do
      post "/admin/posts", params: { post: { title: "", body: "Kept text" } }
    end

    assert_response :unprocessable_entity
    assert_includes response.body, "can&#39;t be blank"
    assert_includes response.body, "Kept text"
  end

  test "edit page prefills values from the record" do
    get "/admin/posts/#{posts(:published_post).id}/edit"

    assert_response :success
    assert_includes response.body, "Edit post"
    assert_select ".jq-breadcrumbs span", text: "Edit"
    assert_includes response.body, 'value="A Published Post"'
  end

  test "updating a valid record stays on the edit page with a toast" do
    record = posts(:draft_post)

    patch "/admin/posts/#{record.id}", params: { post: { title: "Renamed" } }

    assert_redirected_to "/admin/posts/#{record.id}/edit"
    follow_redirect!
    assert_includes response.body, "Saved"
    assert_equal "Renamed", record.reload.title
  end

  test "updating with invalid data re-renders with errors" do
    record = posts(:draft_post)

    patch "/admin/posts/#{record.id}", params: { post: { title: "" } }

    assert_response :unprocessable_entity
    assert_equal "A Draft Post", record.reload.title
  end

  test "fields outside the schema cannot be mass-assigned" do
    record = posts(:draft_post)

    patch "/admin/posts/#{record.id}", params: { post: { title: "Renamed", created_at: 10.years.ago } }

    assert_equal record.created_at, record.reload.created_at
  end

  test "destroying a record redirects to the index" do
    record = posts(:draft_post)

    assert_difference -> { Post.count }, -1 do
      delete "/admin/posts/#{record.id}"
    end

    assert_redirected_to "/admin/posts"
    follow_redirect!
    assert_includes response.body, "Post deleted"
  end

  test "index shows row actions and the new button" do
    get "/admin/posts"

    assert_includes response.body, "New post"
    assert_includes response.body, "/admin/posts/create"
    assert_includes response.body, "/admin/posts/#{posts(:draft_post).id}/edit"
    assert_includes response.body, "jq-row-action--danger"
  end

  test "layout ships the confirmation dialog" do
    get "/admin/posts"

    assert_includes response.body, 'id="jquard-confirm-dialog"'
    assert_includes response.body, "jquard/application"
  end
end
