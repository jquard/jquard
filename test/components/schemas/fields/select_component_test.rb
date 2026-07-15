require "test_helper"
require "view_component/test_case"
require "support/form_builder_helper"

class SelectComponentTest < ViewComponent::TestCase
  include FormBuilderHelper

  test "renders options with the record value selected" do
    field = Jquard::Schemas::Fields::Select.make(:status).options(draft: "Draft", published: "Published")
    record = posts(:published_post)

    render_inline Jquard::Schemas::Fields::SelectComponent.new(component: field, form: builder_for(record), record: record)

    assert_selector "select.jq-input[name='post[status]']"
    assert_selector "option[value='draft']", text: "Draft"
    assert_selector "option[value='published'][selected]"
  end

  test "placeholder renders as blank option" do
    field = Jquard::Schemas::Fields::Select.make(:status).options(draft: "Draft").placeholder("Pick one")
    record = Post.new(status: nil)

    render_inline Jquard::Schemas::Fields::SelectComponent.new(component: field, form: builder_for(record), record: record)

    assert_selector "option[value='']", text: "Pick one"
  end
end
