module Jquard
  module Schemas
    class FormComponent < Jquard::ApplicationComponent
      def initialize(schema:, record:, resource:)
        @schema = schema
        @record = record
        @resource = resource
      end

      private

      attr_reader :schema, :record, :resource

      def form_url
        if record.persisted?
          helpers.resource_record_path(resource.slug, record.id)
        else
          helpers.resource_path(resource.slug)
        end
      end

      def cancel_url
        helpers.resource_path(resource.slug)
      end

      def submit_label
        record.persisted? ? "Save changes" : "Create"
      end
    end
  end
end
