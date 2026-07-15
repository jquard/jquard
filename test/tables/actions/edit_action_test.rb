require "test_helper"

class EditActionTest < ActiveSupport::TestCase
  test "defaults" do
    action = Jquard::Tables::Actions::EditAction.make

    assert_equal "Edit", action.label
    assert_equal "pencil-square", action.icon
  end

  test "label and icon chain" do
    action = Jquard::Tables::Actions::EditAction.make.label("Change").icon("pencil")

    assert_equal "Change", action.label
    assert_equal "pencil", action.icon
  end
end
