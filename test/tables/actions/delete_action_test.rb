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

  test "confirm heading defaults to nil and chains" do
    action = Jquard::Tables::Actions::DeleteAction.make

    assert_nil action.confirm_heading
    assert_equal "Remove post", action.confirm_heading("Remove post").confirm_heading
  end

  test "confirm button falls back to the label" do
    action = Jquard::Tables::Actions::DeleteAction.make

    assert_equal "Delete", action.confirm_button
    assert_equal "Destroy!", action.confirm_button("Destroy!").confirm_button
  end
end
