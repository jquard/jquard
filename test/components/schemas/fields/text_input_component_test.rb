require "test_helper"
require "view_component/test_case"
require "support/form_builder_helper"

class TextInputComponentTest < ViewComponent::TestCase
  include FormBuilderHelper

  test "renders a text input with attributes from the field" do
    field = Jquard::Schemas::Fields::TextInput.make(:title).required.max_length(255).placeholder("The title")
    record = Post.new

    render_inline Jquard::Schemas::Fields::TextInputComponent.new(component: field, form: builder_for(record), record: record)

    assert_selector "input.jq-input[type='text'][name='post[title]'][required][maxlength='255'][placeholder='The title']"
  end

  test "renders variant input types" do
    field = Jquard::Schemas::Fields::TextInput.make(:title).email
    record = Post.new

    render_inline Jquard::Schemas::Fields::TextInputComponent.new(component: field, form: builder_for(record), record: record)

    assert_selector "input[type='email']"
  end

  test "marks inputs with validation errors" do
    record = Post.new(title: "")
    record.validate
    field = Jquard::Schemas::Fields::TextInput.make(:title)

    render_inline Jquard::Schemas::Fields::TextInputComponent.new(component: field, form: builder_for(record), record: record)

    assert_selector "input.jq-input--error"
  end
end
