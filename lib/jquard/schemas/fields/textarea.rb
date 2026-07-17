module Jquard
  module Schemas
    module Fields
      class Textarea < Field
        def rows(count = nil)
          return @rows || 4 if count.nil?

          @rows = count
          self
        end
      end
    end
  end
end
