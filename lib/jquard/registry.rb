module Jquard
  class Registry
    def initialize
      @resources = {}
    end

    def register(resource_class)
      @resources[resource_class.slug] = resource_class
    end

    def fetch(slug, &fallback)
      @resources.fetch(slug.to_s, &fallback)
    end

    def resources
      @resources.values
    end

    def slugs
      @resources.keys
    end

    def clear
      @resources.clear
    end
  end
end
