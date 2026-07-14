require "test_helper"
require "view_component/test_case"

class ColumnComponentsTest < ViewComponent::TestCase
  def vc_test_controller_class
    Jquard::ResourcesController
  end

  test "text column renders plain value" do
    column = Jquard::Tables::Columns::TextColumn.make(:title)

    render_inline Jquard::Tables::Columns::TextColumnComponent.new(column: column, record: posts(:draft_post))

    assert_selector "span", text: "A Draft Post"
    assert_no_selector ".jq-badge"
  end

  test "text column renders badge with mapped color" do
    column = Jquard::Tables::Columns::TextColumn.make(:status).badge.color(reviewing: :warning)

    render_inline Jquard::Tables::Columns::TextColumnComponent.new(column: column, record: posts(:reviewing_post))

    assert_selector "span.jq-badge.jq-badge--warning", text: "reviewing"
  end

  test "icon column renders boolean states as icons" do
    column = Jquard::Tables::Columns::IconColumn.make(:featured).boolean

    render_inline Jquard::Tables::Columns::IconColumnComponent.new(column: column, record: posts(:reviewing_post))
    assert_selector "svg.jq-bool-icon--true"

    render_inline Jquard::Tables::Columns::IconColumnComponent.new(column: column, record: posts(:draft_post))
    assert_selector "svg.jq-bool-icon--false"
  end
end
