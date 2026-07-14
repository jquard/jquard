module Jquard
  module Tables
    module Columns
      class TextColumn < Column
        def format(&block)
          @formatter = block
          self
        end

        def date_time(pattern = "%b %-d, %Y %H:%M")
          format { |state| state.strftime(pattern) }
        end

        def badge(value = true)
          @badge = value
          self
        end

        def badge?
          !!@badge
        end

        def color(map)
          @color_map = map.transform_keys(&:to_sym)
          self
        end

        def color_for(state)
          (@color_map || {}).fetch(state.to_s.to_sym, :gray)
        end

        def limit(count)
          @limit = count
          self
        end

        def display_value(record)
          state = state_for(record)
          return "" if state.nil?

          value = @formatter ? @formatter.call(state) : state
          value = value.to_s
          @limit ? value.truncate(@limit) : value
        end
      end
    end
  end
end
