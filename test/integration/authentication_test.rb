require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "redirects unauthenticated visitors to the sign in page" do
    get "/admin/posts"

    assert_redirected_to "/users/sign_in"
  end

  test "sign in page renders inside the jquard auth layout" do
    get "/users/sign_in"

    assert_response :success
    assert_includes response.body, "jq-auth-card"
    assert_includes response.body, "Jquard Admin Panel"
    assert_includes response.body, "--jq-primary-600: #cc342d"
  end

  test "signing in returns to the originally requested page" do
    get "/admin/posts"
    assert_redirected_to "/users/sign_in"

    post "/users/sign_in", params: { user: { email: "admin@example.com", password: "password" } }

    assert_redirected_to "/admin/posts"
    follow_redirect!
    assert_response :success
  end

  test "failed sign in shows the flash alert in the auth layout" do
    post "/users/sign_in", params: { user: { email: "admin@example.com", password: "wrong" } }

    assert_response :unprocessable_entity
    assert_includes response.body, "jq-auth-flash--alert"
  end
end
