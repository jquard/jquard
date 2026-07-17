require "test_helper"
require "view_component/test_case"

class EditActionComponentTest < ViewComponent::TestCase
  def vc_test_controller_class
    Jquard::ResourcesController
  end

  test "links to the edit page breaking out of the table frame" do
    render_inline Jquard::Tables::Actions::EditActionComponent.new(
      action: Jquard::Tables::Actions::EditAction.make,
      resource: Jquard::Resources::Posts::PostResource,
      record: posts(:draft_post)
    )

    assert_selector "a.jq-row-action[href='/admin/posts/#{posts(:draft_post).id}/edit'][data-turbo-frame='_top']", text: "Edit"
    assert_selector "svg.jq-row-action-icon"
  end
end
