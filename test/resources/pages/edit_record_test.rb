require "test_helper"

class EditRecordTest < ActiveSupport::TestCase
  def page
    Jquard::Resources::Pages::EditRecord.new(resource: Jquard::Resources::Posts::PostResource)
  end

  test "title and notification defaults" do
    assert_equal "Edit post", page.title
    assert_equal "Saved", page.saved_notification_message
  end

  test "mutate hooks pass data through by default" do
    assert_equal({ "a" => 1 }, page.mutate_form_data_before_fill({ "a" => 1 }))
    assert_equal({ "a" => 1 }, page.mutate_form_data_before_save({ "a" => 1 }))
  end

  test "handle_record_update reports success and failure" do
    record = posts(:draft_post)

    assert page.handle_record_update(record, { "title" => "Updated" })
    assert_not page.handle_record_update(record, { "title" => "" })
  end

  test "redirect defaults to nil" do
    assert_nil page.redirect_url_after_save(posts(:draft_post))
  end
end
