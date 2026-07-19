require "test_helper"

class Jquard::Navigation::ItemTest < ActiveSupport::TestCase
  def item(path:, exact: false)
    Jquard::Navigation::Item.new(label: "Posts", icon: "home", path: path, exact: exact)
  end

  test "prefix items match nested paths" do
    assert item(path: "/admin/posts").active?("/admin/posts")
    assert item(path: "/admin/posts").active?("/admin/posts/1/edit")
  end

  test "prefix items do not match sibling paths sharing a stem" do
    refute item(path: "/admin/post").active?("/admin/posts")
  end

  test "exact items match only themselves" do
    assert item(path: "/admin", exact: true).active?("/admin")
    refute item(path: "/admin", exact: true).active?("/admin/posts")
  end

  test "exact items ignore a trailing slash" do
    assert item(path: "/admin/", exact: true).active?("/admin")
    assert item(path: "/admin", exact: true).active?("/admin/")
  end
end
