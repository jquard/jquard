module Jquard
  module Tables
    module Actions
      class DeleteAction < Action
        def confirm(value = nil)
          return @confirm || "Are you sure you would like to do this?" if value.nil?

          @confirm = value
          self
        end

        def confirm_heading(value = nil)
          return @confirm_heading if value.nil?

          @confirm_heading = value
          self
        end

        def confirm_button(value = nil)
          return @confirm_button || label if value.nil?

          @confirm_button = value
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
