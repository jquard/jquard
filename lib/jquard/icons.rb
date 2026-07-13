module Jquard
  module Icons
    NAME_FORMAT = %r{\A(?:(outline|solid)/)?([a-z0-9-]+)\z}

    @cache = {}

    class << self
      def render(name, css_class: nil)
        svg = @cache[name.to_s] ||= read(name.to_s)
        css_class ? svg.sub("<svg", %(<svg class="#{css_class}")) : svg
      end

      private

      def read(name)
        variant, base = name.match(NAME_FORMAT)&.captures
        path = Jquard::Engine.root.join("lib/jquard/icons", variant || "outline", "#{base}.svg") if base
        unless path&.exist?
          raise Jquard::Error, "Unknown icon #{name.inspect}. Use a Heroicon name like \"user-group\" or \"solid/user-group\"."
        end

        path.read
      end
    end
  end
end
