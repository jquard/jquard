module Jquard
  module Tables
    module Actions
      class Action
        include Jquard::ComponentDispatch

        def self.make
          new
        end

        def label(value = nil)
          return @label || default_label if value.nil?

          @label = value
          self
        end

        def icon(value = nil)
          return @icon || default_icon if value.nil?

          @icon = value
          self
        end
      end
    end
  end
end
