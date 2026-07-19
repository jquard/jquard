module Jquard
  module Pages
    class Page
      class << self
        attr_writer :slug, :route_path, :title, :navigation_icon, :navigation_label, :navigation_group, :navigation_sort

        def slug
          @slug || name.demodulize.underscore.dasherize
        end

        def route_path
          @route_path || slug
        end

        def title
          @title || name.demodulize.titleize
        end

        def navigation_icon
          @navigation_icon || "document"
        end

        def navigation_label
          @navigation_label || title
        end

        def navigation_group
          @navigation_group
        end

        def navigation_sort
          @navigation_sort || 0
        end

        def visible?
          true
        end
      end

      def slug
        self.class.slug
      end

      def title
        self.class.title
      end

      def navigation_label
        self.class.navigation_label
      end

      def component
        raise Jquard::Error, "#{self.class.name} does not define #component."
      end
    end
  end
end
