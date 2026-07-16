require "test_helper"
require "view_component/test_case"

class DeleteActionComponentTest < ViewComponent::TestCase
  def vc_test_controller_class
    Jquard::ResourcesController
  end

  test "renders a delete button with confirmation" do
    render_inline Jquard::Tables::Actions::DeleteActionComponent.new(
      action: Jquard::Tables::Actions::DeleteAction.make,
      resource: Jquard::Resources::Posts::PostResource,
      record: posts(:draft_post)
    )

    assert_selector "form[action='/admin/posts/#{posts(:draft_post).id}'][data-turbo-frame='_top'][data-turbo-confirm]"
    assert_selector "input[name='_method'][value='delete']", visible: false
    assert_selector "button.jq-row-action--danger", text: "Delete"
  end
end
