require "test_helper"

class Jquard::Pages::DashboardTest < ActiveSupport::TestCase
  test "is routed at the panel root" do
    assert_equal "/", Jquard::Pages::Dashboard.route_path
  end

  test "keeps a slug of its own alongside the root path" do
    assert_equal "dashboard", Jquard::Pages::Dashboard.slug
  end

  test "sorts above every resource in the navigation" do
    assert_operator Jquard::Pages::Dashboard.navigation_sort, :<, 0
  end

  test "is registered" do
    assert Jquard.registry.page?("dashboard")
    assert_equal Jquard::Pages::Dashboard, Jquard.registry.fetch_page("dashboard")
  end

  test "builds its component" do
    assert_instance_of Jquard::Pages::DashboardComponent, Jquard::Pages::Dashboard.new.component
  end
end
