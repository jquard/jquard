module Jquard
  module Schemas
    module Layouts
      class Layout
        include Jquard::ComponentDispatch

        def schema(components = nil)
          return @schema ||= [] if components.nil?

          @schema = components
          self
        end

        def columns(count = nil)
          return @columns || 1 if count.nil?

          @columns = count
          self
        end
      end
    end
  end
end
