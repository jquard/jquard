require "test_helper"

class LayoutTest < ActiveSupport::TestCase
  test "schema acts as setter with chaining and reader" do
    layout = Jquard::Schemas::Layouts::Layout.new
    field = Jquard::Schemas::Fields::TextInput.make(:title)

    assert_equal [], layout.schema
    assert_same layout, layout.schema([ field ])
    assert_equal [ field ], layout.schema
  end

  test "columns defaults to 1" do
    layout = Jquard::Schemas::Layouts::Layout.new

    assert_equal 1, layout.columns
    assert_equal 3, layout.columns(3).columns
  end
end
