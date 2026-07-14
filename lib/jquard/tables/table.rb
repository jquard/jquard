module Jquard
  module Tables
    class Table
      def columns(list = nil)
        return @columns ||= [] if list.nil?

        @columns = list
        self
      end

      def default_sort(name = nil, direction = :asc)
        return @default_sort if name.nil?

        @default_sort = [ name.to_sym, direction.to_sym ]
        self
      end

      def searchable_columns
        columns.select(&:searchable?)
      end

      def searchable?
        searchable_columns.any?
      end

      def sortable_column(name)
        columns.find { |column| column.sortable? && column.name.to_s == name.to_s }
      end

      def apply_default_columns(model)
        return self if columns.any?

        columns(model.column_names.map { |name| Columns::TextColumn.make(name) })
      end
    end
  end
end
