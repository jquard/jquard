require "test_helper"

class AuthenticationGuardTest < ActionDispatch::IntegrationTest
  setup do
    @original_authenticate = Jquard.config.authenticate
    @original_current_user_method = Jquard.config.current_user_method
    @original_sign_out_path = Jquard.config.sign_out_path
    Jquard.config.instance_variable_set(:@authenticate, nil)
  end

  teardown do
    Jquard.config.instance_variable_set(:@authenticate, @original_authenticate)
    Jquard.config.current_user_method = @original_current_user_method
    Jquard.config.sign_out_path = @original_sign_out_path
  end

  test "the panel raises without configured authentication" do
    error = assert_raises(Jquard::Error) { get "/admin/posts" }
    assert_match(/refuses to serve the admin panel without authentication/, error.message)
  end

  test "an intentionally empty authenticate block keeps the panel public without raising" do
    Jquard.config.authenticate_with { }

    get "/admin/posts"

    assert_response :success
  end

  test "the panel renders without a user model or any user menu configuration" do
    Jquard.config.authenticate_with { }
    Jquard.config.current_user_method = nil
    Jquard.config.sign_out_path = nil

    get "/admin/posts"

    assert_response :success
    assert_select ".jq-topbar"
    assert_select ".jq-user-menu", count: 0
    assert_includes response.body, "A Published Post"
  end

  test "a configured current_user_method the controller does not respond to is ignored" do
    Jquard.config.authenticate_with { }
    Jquard.config.current_user_method = :definitely_not_a_controller_method

    get "/admin/posts"

    assert_response :success
    assert_select ".jq-user-menu", count: 0
  end
end
