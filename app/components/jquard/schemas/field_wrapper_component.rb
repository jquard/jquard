module Jquard
  module Schemas
    class FieldWrapperComponent < Jquard::ApplicationComponent
      def initialize(field:, record:, inline: false)
        @field = field
        @record = record
        @inline = inline
      end

      private

      attr_reader :field, :record

      def inline?
        @inline
      end

      def input_id
        "#{record.model_name.param_key}_#{field.name}"
      end

      def error_message
        return nil unless record.respond_to?(:errors)

        record.errors[field.name].first
      end

      def wrapper_classes
        class_names("jq-field", "jq-field--error" => error_message.present?)
      end

      def span_style
        case field.column_span
        when :full then "grid-column: 1 / -1;"
        when Integer then "grid-column: span #{field.column_span} / span #{field.column_span};"
        end
      end
    end
  end
end
