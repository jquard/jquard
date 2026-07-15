module Jquard
  module Schemas
    module Layouts
      class Grid < Layout
        def self.make(columns = 2)
          new.columns(columns)
        end
      end
    end
  end
end
