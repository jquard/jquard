require "test_helper"

class GridTest < ActiveSupport::TestCase
  test "make sets columns with a default of 2" do
    assert_equal 2, Jquard::Schemas::Layouts::Grid.make.columns
    assert_equal 3, Jquard::Schemas::Layouts::Grid.make(3).columns
  end
end
