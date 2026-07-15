require "test_helper"

class ListRecordsTest < ActiveSupport::TestCase
  test "title uses the navigation label" do
    page = Jquard::Resources::Pages::ListRecords.new(resource: Jquard::Resources::Posts::PostResource)

    assert_equal "Posts", page.title
  end
end
