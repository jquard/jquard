module Jquard
  module Tables
    class Query
      PER_PAGE_OPTIONS = [ 10, 25, 50 ].freeze
      DEFAULT_PER_PAGE = 10

      Result = Struct.new(
        :records, :total_count, :page, :pages, :per_page, :from, :to, :sort, :direction,
        keyword_init: true
      )

      def initialize(table:, scope:, params:)
        @table = table
        @scope = scope
        @params = params.to_h.symbolize_keys
      end

      def result
        scope = search(@scope)
        scope, sort, direction = order(scope)
        total_count = scope.count
        per_page = resolve_per_page
        pages = [ (total_count.to_f / per_page).ceil, 1 ].max
        page = @params[:page].to_i.clamp(1, pages)
        records = scope.offset((page - 1) * per_page).limit(per_page)

        Result.new(
          records: records,
          total_count: total_count,
          page: page,
          pages: pages,
          per_page: per_page,
          from: total_count.zero? ? 0 : (page - 1) * per_page + 1,
          to: [ page * per_page, total_count ].min,
          sort: sort,
          direction: direction
        )
      end

      private

      def search(scope)
        term = @params[:q].to_s.strip
        return scope if term.empty? || @table.searchable_columns.empty?

        pattern = "%#{ActiveRecord::Base.sanitize_sql_like(term)}%"
        condition = @table.searchable_columns
          .map { |column| scope.model.arel_table[column.name].matches(pattern) }
          .reduce(:or)
        scope.where(condition)
      end

      def order(scope)
        direction = %w[asc desc].include?(@params[:direction].to_s) ? @params[:direction].to_s : "asc"

        if (column = @table.sortable_column(@params[:sort]))
          [ scope.order(column.name => direction), column.name.to_s, direction ]
        elsif (default = @table.default_sort)
          [ scope.order(default[0] => default[1]), nil, default[1].to_s ]
        else
          [ scope.order(scope.model.primary_key => :asc), nil, "asc" ]
        end
      end

      def resolve_per_page
        requested = @params[:per_page].to_i
        PER_PAGE_OPTIONS.include?(requested) ? requested : DEFAULT_PER_PAGE
      end
    end
  end
end
