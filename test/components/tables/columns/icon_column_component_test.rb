require "test_helper"
require "view_component/test_case"

class IconColumnComponentTest < ViewComponent::TestCase
  def vc_test_controller_class
    Jquard::ResourcesController
  end

  test "renders true states as a check icon" do
    column = Jquard::Tables::Columns::IconColumn.make(:featured).boolean

    render_inline Jquard::Tables::Columns::IconColumnComponent.new(column: column, record: posts(:reviewing_post))

    assert_selector "svg.jq-bool-icon.jq-bool-icon--true"
  end

  test "renders false states as a cross icon" do
    column = Jquard::Tables::Columns::IconColumn.make(:featured).boolean

    render_inline Jquard::Tables::Columns::IconColumnComponent.new(column: column, record: posts(:draft_post))

    assert_selector "svg.jq-bool-icon.jq-bool-icon--false"
  end

  test "renders the raw state without boolean mode" do
    column = Jquard::Tables::Columns::IconColumn.make(:featured)

    render_inline Jquard::Tables::Columns::IconColumnComponent.new(column: column, record: posts(:draft_post))

    assert_selector "span", text: "false"
    assert_no_selector "svg"
  end
end
