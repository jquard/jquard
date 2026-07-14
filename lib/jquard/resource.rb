module Jquard
  class Resource
    class << self
      attr_writer :model, :navigation_icon, :navigation_label, :navigation_group, :navigation_sort

      def inherited(subclass)
        super
        Jquard.registry.register(subclass) if subclass.name
      end

      def model
        @model or raise Jquard::Error, "#{name} does not declare a model. Add `self.model = YourModel`."
      end

      def slug
        name.demodulize.delete_suffix("Resource").underscore.pluralize
      end

      def table(table)
        table
      end

      def build_table
        table(Jquard::Tables::Table.new).apply_default_columns(model)
      end

      def navigation_icon
        @navigation_icon || "rectangle-stack"
      end

      def navigation_label
        @navigation_label || slug.titleize
      end

      def navigation_group
        @navigation_group
      end

      def navigation_sort
        @navigation_sort || 0
      end
    end
  end
end
