module Jquard
  module Schemas
    module Fields
      class HiddenComponent < FieldComponent
        def call
          form.hidden_field(field.name)
        end
      end
    end
  end
end
