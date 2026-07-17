require "test_helper"
require "view_component/test_case"

class FieldWrapperComponentTest < ViewComponent::TestCase
  test "renders label with required mark and content" do
    field = Jquard::Schemas::Fields::TextInput.make(:title).required

    render_inline Jquard::Schemas::FieldWrapperComponent.new(field: field, record: Post.new).with_content("<input/>".html_safe)

    assert_selector "label.jq-label", text: "Title"
    assert_selector ".jq-required", text: "*"
    assert_selector "input"
  end

  test "renders the first validation error" do
    record = Post.new(title: "")
    record.validate
    field = Jquard::Schemas::Fields::TextInput.make(:title)

    render_inline Jquard::Schemas::FieldWrapperComponent.new(field: field, record: record).with_content("x".html_safe)

    assert_selector ".jq-field--error"
    assert_selector ".jq-field-error", text: "can't be blank"
  end

  test "renders helper text" do
    field = Jquard::Schemas::Fields::TextInput.make(:title).helper_text("Be creative")

    render_inline Jquard::Schemas::FieldWrapperComponent.new(field: field, record: Post.new).with_content("x".html_safe)

    assert_selector ".jq-helper-text", text: "Be creative"
  end

  test "full column span sets the grid style" do
    field = Jquard::Schemas::Fields::TextInput.make(:title).column_span_full

    render_inline Jquard::Schemas::FieldWrapperComponent.new(field: field, record: Post.new).with_content("x".html_safe)

    assert_selector ".jq-field[style*='grid-column: 1 / -1']"
  end
end
