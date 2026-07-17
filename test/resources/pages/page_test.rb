require "test_helper"

class PageTest < ActiveSupport::TestCase
  test "infers the resource from the page namespace" do
    assert_equal Jquard::Resources::Posts::PostResource,
      Jquard::Resources::Posts::Pages::CreatePost.inferred_resource
  end

  test "an explicitly passed resource wins" do
    page = Jquard::Resources::Posts::Pages::CreatePost.new(resource: Jquard::Resources::Posts::PostResource)

    assert_equal Jquard::Resources::Posts::PostResource, page.resource
  end
end
