require "test_helper"

class DeleteActionTest < ActiveSupport::TestCase
  test "defaults" do
    action = Jquard::Tables::Actions::DeleteAction.make

    assert_equal "Delete", action.label
    assert_equal "trash", action.icon
    assert_match(/Are you sure/, action.confirm)
  end

  test "confirm chains" do
    action = Jquard::Tables::Actions::DeleteAction.make.confirm("Really?")

    assert_equal "Really?", action.confirm
  end
end
