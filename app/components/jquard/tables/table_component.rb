module Jquard
  module Tables
    class TableComponent < Jquard::ApplicationComponent
      def initialize(table:, resource:, result:, query_params: {})
        @table = table
        @resource = resource
        @result = result
        @query_params = query_params.to_h.symbolize_keys
      end

      private

      attr_reader :table, :resource, :result, :query_params

      def search_url
        helpers.resource_path(resource.slug)
      end

      def url_with(overrides)
        helpers.resource_path(resource.slug, **query_params.merge(overrides).compact_blank)
      end

      def current_sort?(column)
        result.sort == column.name.to_s
      end

      def sort_url(column)
        direction = current_sort?(column) && result.direction == "asc" ? "desc" : "asc"
        url_with(sort: column.name, direction: direction, page: nil)
      end

      def sort_icon(column)
        return "chevron-up-down" unless current_sort?(column)

        result.direction == "asc" ? "chevron-up" : "chevron-down"
      end

      def page_url(page)
        url_with(page: page == 1 ? nil : page)
      end

      def page_items
        return (1..result.pages).to_a if result.pages <= 5

        window = ((result.page - 1)..(result.page + 1)).select { |page| page > 1 && page < result.pages }
        items = [ 1 ]
        items << :gap if window.first > 2
        items.concat(window)
        items << :gap if window.last < result.pages - 1
        items << result.pages
        items
      end
    end
  end
end
