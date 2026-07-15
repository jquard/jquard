require "test_helper"

class SelectTest < ActiveSupport::TestCase
  test "options default empty and chain" do
    field = Jquard::Schemas::Fields::Select.make(:status)

    assert_equal({}, field.options)
    assert_same field, field.options(draft: "Draft")
    assert_equal({ draft: "Draft" }, field.options)
  end

  test "choices converts options for the select builder" do
    field = Jquard::Schemas::Fields::Select.make(:status).options(draft: "Draft", published: "Published")

    assert_equal [ [ "Draft", "draft" ], [ "Published", "published" ] ], field.choices
  end
end
