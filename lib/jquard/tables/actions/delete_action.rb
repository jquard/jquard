module Jquard
  module Tables
    module Actions
      class DeleteAction < Action
        def confirm(value = nil)
          return @confirm || "Are you sure you want to delete this record?" if value.nil?

          @confirm = value
          self
        end

        private

        def default_label
          "Delete"
        end

        def default_icon
          "trash"
        end
      end
    end
  end
end
