require "test_helper"

class CreateRecordTest < ActiveSupport::TestCase
  def page
    Jquard::Resources::Pages::CreateRecord.new(resource: Jquard::Resources::Posts::PostResource)
  end

  test "title and notification use the singular label" do
    assert_equal "Create post", page.title
    assert_equal "Post created", page.created_notification_message
  end

  test "mutate hook passes data through by default" do
    assert_equal({ "title" => "X" }, page.mutate_form_data_before_create({ "title" => "X" }))
  end

  test "handle_record_creation persists valid data" do
    record = page.handle_record_creation(Post, { "title" => "Created via page" })

    assert_predicate record, :persisted?
  end

  test "handle_record_creation returns the invalid record unsaved" do
    record = page.handle_record_creation(Post, { "title" => "" })

    assert_not record.persisted?
    assert record.errors[:title].any?
  end

  test "redirect defaults to nil" do
    assert_nil page.redirect_url_after_create(posts(:draft_post))
  end
end
