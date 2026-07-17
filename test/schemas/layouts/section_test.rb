require "test_helper"

class SectionTest < ActiveSupport::TestCase
  test "make stores the heading" do
    assert_equal "Content", Jquard::Schemas::Layouts::Section.make("Content").heading
    assert_nil Jquard::Schemas::Layouts::Section.make.heading
  end

  test "description reads and chains" do
    section = Jquard::Schemas::Layouts::Section.make("Content")

    assert_nil section.description
    assert_same section, section.description("About this")
    assert_equal "About this", section.description
  end
end
