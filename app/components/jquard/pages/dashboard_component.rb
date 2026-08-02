module Jquard
  module Pages
    class DashboardComponent < Jquard::ApplicationComponent
      def initialize(page:)
        @page = page
      end

      private

      attr_reader :page
    end
  end
end
