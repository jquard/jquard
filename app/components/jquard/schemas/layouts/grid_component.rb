module Jquard
  module Schemas
    module Layouts
      class GridComponent < Jquard::ApplicationComponent
        def initialize(component:, form:, record:)
          @grid = component
          @form = form
          @record = record
        end

        private

        attr_reader :grid, :form, :record

        def grid_style
          "grid-template-columns: repeat(#{grid.columns}, minmax(0, 1fr));"
        end
      end
    end
  end
end
