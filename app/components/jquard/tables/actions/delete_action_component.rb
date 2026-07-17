module Jquard
  module Tables
    module Actions
      class DeleteActionComponent < Jquard::ApplicationComponent
        def initialize(action:, resource:, record:)
          @action = action
          @resource = resource
          @record = record
        end

        private

        attr_reader :action, :resource, :record

        def confirm_heading
          action.confirm_heading || "Delete #{resource.singular_label.downcase}"
        end
      end
    end
  end
end
