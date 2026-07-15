module Jquard
  module Schemas
    module Fields
      class FieldComponent < Jquard::ApplicationComponent
        def initialize(component:, form:, record:)
          @field = component
          @form = form
          @record = record
        end

        private

        attr_reader :field, :form, :record

        def wrapper(inline: false)
          Jquard::Schemas::FieldWrapperComponent.new(field: field, record: record, inline: inline)
        end

        def input_classes
          class_names("jq-input", "jq-input--error" => error?)
        end

        def error?
          record.respond_to?(:errors) && record.errors[field.name].any?
        end

        def base_options
          {
            class: input_classes,
            placeholder: field.placeholder,
            required: field.required? || nil,
            disabled: field.disabled? || nil
          }.compact
        end
      end
    end
  end
end
