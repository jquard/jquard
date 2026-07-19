module Jquard
  module Pages
    class Dashboard < Page
      self.slug = "dashboard"
      self.route_path = "/"
      self.navigation_icon = "home"
      self.navigation_sort = -100

      def component
        Jquard::Pages::DashboardComponent.new(page: self)
      end
    end
  end
end
