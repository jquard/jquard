module Jquard
  module Schemas
    module Layouts
      class SectionComponent < Jquard::ApplicationComponent
        def initialize(component:, form:, record:)
          @section = component
          @form = form
          @record = record
        end

        private

        attr_reader :section, :form, :record

        def grid_style
          "grid-template-columns: repeat(#{section.columns}, minmax(0, 1fr));"
        end
      end
    end
  end
end
