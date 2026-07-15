module Jquard
  module Tables
    module Columns
      class TextColumnComponent < Jquard::ApplicationComponent
        def initialize(column:, record:)
          @column = column
          @record = record
        end

        private

        attr_reader :column, :record

        def display
          column.display_value(record)
        end

        def badge_class
          "jq-badge jq-badge--#{column.color_for(column.state_for(record))}"
        end
      end
    end
  end
end
