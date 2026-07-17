module Jquard
  module Schemas
    module Fields
      class TextInput < Field
        def email(value = true)
          @input_type = :email if value
          self
        end

        def password(value = true)
          @input_type = :password if value
          self
        end

        def numeric(value = true)
          @input_type = :number if value
          self
        end

        def input_type
          @input_type || :text
        end

        def max_length(count = nil)
          return @max_length if count.nil?

          @max_length = count
          self
        end
      end
    end
  end
end
