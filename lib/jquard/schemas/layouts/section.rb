module Jquard
  module Schemas
    module Layouts
      class Section < Layout
        attr_reader :heading

        def self.make(heading = nil)
          new(heading)
        end

        def initialize(heading = nil)
          @heading = heading
        end

        def description(value = nil)
          return @description if value.nil?

          @description = value
          self
        end
      end
    end
  end
end
