module Jquard
  module Resources
    module Pages
      class ListRecords < Page
        def title
          resource.navigation_label
        end
      end
    end
  end
end
