module Jquard
  module Navigation
    class Item
      attr_reader :label, :icon, :path, :group, :sort

      def initialize(label:, icon:, path:, group: nil, sort: 0, exact: false)
        @label = label
        @icon = icon
        @path = path
        @group = group
        @sort = sort
        @exact = exact
      end

      # Resources match by prefix so that create/edit screens keep the parent
      # resource highlighted; pages match exactly or the dashboard at "/" would
      # light up for every route beneath it.
      def active?(current_path)
        return current_path.chomp("/") == path.chomp("/") if @exact

        current_path == path || current_path.start_with?("#{path}/")
      end
    end
  end
end
