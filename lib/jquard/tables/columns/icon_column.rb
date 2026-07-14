module Jquard
  module Tables
    module Columns
      class IconColumn < Column
        def boolean(value = true)
          @boolean = value
          self
        end

        def boolean?
          !!@boolean
        end
      end
    end
  end
end
