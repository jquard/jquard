require "test_helper"
require "view_component/test_case"

class FormComponentTest < ViewComponent::TestCase
  def vc_test_controller_class
    Jquard::ResourcesController
  end

  def schema
    Jquard::Schemas::Schema.new.components([ Jquard::Schemas::Fields::TextInput.make(:title) ])
  end

  test "posts to the collection url for new records" do
    render_inline Jquard::Schemas::FormComponent.new(
      schema: schema, record: Post.new, resource: Jquard::Resources::Posts::PostResource
    )

    assert_selector "form[action='/admin/posts'][method='post']"
    assert_selector "input[type='submit'][value='Create']"
    assert_selector "input[name='post[title]']"
  end

  test "patches to the record url for persisted records" do
    render_inline Jquard::Schemas::FormComponent.new(
      schema: schema, record: posts(:draft_post), resource: Jquard::Resources::Posts::PostResource
    )

    assert_selector "input[name='_method'][value='patch']", visible: false
    assert_selector "input[type='submit'][value='Save changes']"
    assert_selector "input[name='post[title]'][value='A Draft Post']"
  end
end
