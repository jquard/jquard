module Jquard
  module Schemas
    module Fields
      class TextInputComponent < FieldComponent
        private

        def input_options
          base_options.merge(maxlength: field.max_length).compact
        end
      end
    end
  end
end
