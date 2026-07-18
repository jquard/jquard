require "test_helper"

class AuthenticationGuardTest < ActionDispatch::IntegrationTest
  setup do
    @original_authenticate = Jquard.config.authenticate
    Jquard.config.instance_variable_set(:@authenticate, nil)
  end

  teardown do
    Jquard.config.instance_variable_set(:@authenticate, @original_authenticate)
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
end
