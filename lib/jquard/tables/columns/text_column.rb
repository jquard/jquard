module Jquard
  module Tables
    module Columns
      class TextColumn < Column
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

        def date_time(format = "%b %-d, %Y %H:%M")
          @date_time_format = format
          self
        end

        def limit(count)
          @limit = count
          self
        end

        def display_value(record)
          value = state_for(record)
          return "" if value.nil?

          value = value.strftime(@date_time_format) if @date_time_format && value.respond_to?(:strftime)
          value = value.to_s
          @limit ? value.truncate(@limit) : value
        end
      end
    end
  end
end
