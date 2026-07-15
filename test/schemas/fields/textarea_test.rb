require "test_helper"

class TextareaTest < ActiveSupport::TestCase
  test "rows defaults to 4 and chains" do
    field = Jquard::Schemas::Fields::Textarea.make(:body)

    assert_equal 4, field.rows
    assert_same field, field.rows(8)
    assert_equal 8, field.rows
  end
end
