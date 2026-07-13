require "test_helper"

class IconsTest < ActiveSupport::TestCase
  test "bare names resolve to the outline variant" do
    svg = Jquard::Icons.render("academic-cap")

    assert_includes svg, "<svg"
    assert_includes svg, "stroke-width"
  end

  test "solid variant resolves via prefix" do
    svg = Jquard::Icons.render("solid/academic-cap")

    assert_includes svg, "<svg"
    refute_includes svg, "stroke-width"
  end

  test "injects a css class into the svg tag" do
    svg = Jquard::Icons.render("academic-cap", css_class: "jq-nav-item-icon")

    assert_includes svg, %(<svg class="jq-nav-item-icon")
  end

  test "unknown names raise a helpful error" do
    error = assert_raises(Jquard::Error) { Jquard::Icons.render("not-a-real-icon") }

    assert_match(/Unknown icon/, error.message)
  end

  test "malformed names raise instead of resolving paths" do
    assert_raises(Jquard::Error) { Jquard::Icons.render("../secrets") }
    assert_raises(Jquard::Error) { Jquard::Icons.render("mini/star") }
  end
end
