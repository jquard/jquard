require "test_helper"
require "view_component/test_case"
require "support/form_builder_helper"

class ToggleComponentTest < ViewComponent::TestCase
  include FormBuilderHelper

  test "renders a switch with the checkbox reflecting the record" do
    field = Jquard::Schemas::Fields::Toggle.make(:featured)
    record = posts(:reviewing_post)

    render_inline Jquard::Schemas::Fields::ToggleComponent.new(component: field, form: builder_for(record), record: record)

    assert_selector ".jq-toggle .jq-toggle-input[type='checkbox'][checked]"
    assert_selector ".jq-toggle-track .jq-toggle-thumb"
    assert_selector "label.jq-field-inline", text: "Featured"
  end
end
