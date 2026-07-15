require "test_helper"

class FieldTest < ActiveSupport::TestCase
  def make(name = :title)
    Jquard::Schemas::Fields::Field.make(name)
  end

  test "chainables return self" do
    field = make

    assert_same field, field.label("X").placeholder("Y").helper_text("Z").required.disabled.default("D").column_span(2)
  end

  test "label defaults to humanized name" do
    assert_equal "Published at", make(:published_at).label
    assert_equal "Go-live", make(:published_at).label("Go-live").label
  end

  test "boolean flags read via predicates" do
    assert_not make.required?
    assert make.required.required?
    assert_not make.disabled?
    assert make.disabled.disabled?
  end

  test "default distinguishes unset from nil-like values" do
    assert_nil make.default
    assert_equal false, make.default(false).default
  end

  test "column_span_full sets the full marker" do
    assert_equal :full, make.column_span_full.column_span
    assert_equal 2, make.column_span(2).column_span
  end

  test "component_class follows the naming convention" do
    assert_equal Jquard::Schemas::Fields::TextInputComponent,
      Jquard::Schemas::Fields::TextInput.make(:title).component_class
  end
end
