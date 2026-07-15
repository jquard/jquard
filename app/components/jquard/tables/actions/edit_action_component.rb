module Jquard
  module Tables
    module Actions
      class EditActionComponent < Jquard::ApplicationComponent
        def initialize(action:, resource:, record:)
          @action = action
          @resource = resource
          @record = record
        end

        private

        attr_reader :action, :resource, :record
      end
    end
  end
end
