require "test_helper"

class TextInputTest < ActiveSupport::TestCase
  test "input_type defaults to text and switches via variants" do
    assert_equal :text, Jquard::Schemas::Fields::TextInput.make(:title).input_type
    assert_equal :email, Jquard::Schemas::Fields::TextInput.make(:contact).email.input_type
    assert_equal :password, Jquard::Schemas::Fields::TextInput.make(:secret).password.input_type
    assert_equal :number, Jquard::Schemas::Fields::TextInput.make(:price).numeric.input_type
  end

  test "max_length reads and chains" do
    field = Jquard::Schemas::Fields::TextInput.make(:title)

    assert_nil field.max_length
    assert_same field, field.max_length(255)
    assert_equal 255, field.max_length
  end
end
