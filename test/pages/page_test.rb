require "test_helper"

class Jquard::Pages::PageTest < ActiveSupport::TestCase
  class ReportsPage < Jquard::Pages::Page; end

  test "derives slug from the class name" do
    assert_equal "reports-page", ReportsPage.slug
  end

  test "derives title from the class name" do
    assert_equal "Reports Page", ReportsPage.title
  end

  test "navigation label defaults to the title" do
    assert_equal "Reports Page", ReportsPage.navigation_label
  end

  test "route path defaults to the slug" do
    assert_equal "reports-page", ReportsPage.route_path
  end

  test "pages are visible by default" do
    assert ReportsPage.visible?
  end

  test "component must be defined by the subclass" do
    error = assert_raises(Jquard::Error) { ReportsPage.new.component }

    assert_match(/does not define #component/, error.message)
  end
end
