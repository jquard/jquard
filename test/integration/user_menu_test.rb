require "test_helper"

class UserMenuTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
  end

  test "topbar shows the user menu with name and avatar initials" do
    get "/admin/posts"

    assert_includes response.body, "jq-user-menu"
    assert_includes response.body, "admin@example.com"
    assert_select ".jq-avatar", text: "A"
  end

  test "user menu contains a sign out button for the devise session" do
    get "/admin/posts"

    assert_select "form.jq-dropdown-form[action=?]", "/users/sign_out" do
      assert_select "input[name=_method][value=delete]"
    end
    assert_includes response.body, "Sign out"
  end

  test "signing out locks the panel again" do
    delete "/users/sign_out"

    get "/admin/posts"
    assert_redirected_to "/users/sign_in"
  end
end
