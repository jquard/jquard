module Jquard
  module Tables
    module Columns
      class IconColumnComponent < Jquard::ApplicationComponent
        def initialize(column:, record:)
          @column = column
          @record = record
        end

        private

        attr_reader :column, :record

        def state
          column.state_for(record)
        end
      end
    end
  end
end
