module Jquard
  module Schemas
    module Fields
      class Select < Field
        def options(map = nil)
          return @options || {} if map.nil?

          @options = map
          self
        end

        def choices
          options.map { |value, label| [ label, value.to_s ] }
        end
      end
    end
  end
end
