module Jquard
  module Tables
    module Columns
      class Column
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

        def searchable(value = true)
          @searchable = value
          self
        end

        def searchable?
          !!@searchable
        end

        def sortable(value = true)
          @sortable = value
          self
        end

        def sortable?
          !!@sortable
        end

        def state_for(record)
          record.public_send(name)
        end

        def component_class
          "#{self.class.name}Component".constantize
        end
      end
    end
  end
end
