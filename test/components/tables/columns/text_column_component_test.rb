require "test_helper"
require "view_component/test_case"

class TextColumnComponentTest < ViewComponent::TestCase
  test "renders the plain value" do
    column = Jquard::Tables::Columns::TextColumn.make(:title)

    render_inline Jquard::Tables::Columns::TextColumnComponent.new(column: column, record: posts(:draft_post))

    assert_selector "span", text: "A Draft Post"
    assert_no_selector ".jq-badge"
  end

  test "renders a badge with the mapped color" do
    column = Jquard::Tables::Columns::TextColumn.make(:status).badge.color(reviewing: :warning)

    render_inline Jquard::Tables::Columns::TextColumnComponent.new(column: column, record: posts(:reviewing_post))

    assert_selector "span.jq-badge.jq-badge--warning", text: "reviewing"
  end

  test "renders formatted values" do
    column = Jquard::Tables::Columns::TextColumn.make(:published_at).date_time("%Y-%m-%d")

    render_inline Jquard::Tables::Columns::TextColumnComponent.new(column: column, record: posts(:published_post))

    assert_selector "span", text: posts(:published_post).published_at.strftime("%Y-%m-%d")
  end
end
