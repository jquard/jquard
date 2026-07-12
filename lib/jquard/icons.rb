module Jquard
  module Icons
    @cache = {}

    class << self
      def render(name, css_class: nil)
        svg = @cache[name.to_s] ||= read(name.to_s)
        css_class ? svg.sub("<svg", %(<svg class="#{css_class}")) : svg
      end

      private

      def read(name)
        path = Jquard::Engine.root.join("lib/jquard/icons", "#{name}.svg")
        raise Jquard::Error, "Unknown icon #{name.inspect}" unless path.exist?

        path.read
      end
    end
  end
end
