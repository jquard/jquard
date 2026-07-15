module Jquard
  module Schemas
    module Fields
      class Field
        include Jquard::ComponentDispatch

        UNSET = Object.new.freeze

        attr_reader :name

        def self.make(name)
          new(name)
        end

        def initialize(name)
          @name = name.to_sym
        end

        def label(value = nil)
          return @label || name.to_s.humanize if value.nil?

          @label = value
          self
        end

        def placeholder(value = nil)
          return @placeholder if value.nil?

          @placeholder = value
          self
        end

        def helper_text(value = nil)
          return @helper_text if value.nil?

          @helper_text = value
          self
        end

        def default(value = UNSET)
          return @default if value.equal?(UNSET)

          @default = value
          self
        end

        def required(value = true)
          @required = value
          self
        end

        def required?
          !!@required
        end

        def disabled(value = true)
          @disabled = value
          self
        end

        def disabled?
          !!@disabled
        end

        def column_span(count = nil)
          return @column_span if count.nil?

          @column_span = count
          self
        end

        def column_span_full
          @column_span = :full
          self
        end
      end
    end
  end
end
