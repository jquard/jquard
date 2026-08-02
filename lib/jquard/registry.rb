module Jquard
  class Registry
    def initialize
      @resources = {}
      @pages = {}
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

    def register_page(page_class)
      @pages[page_class.slug] = page_class
    end

    def fetch_page(slug, &fallback)
      @pages.fetch(slug.to_s, &fallback)
    end

    def page?(slug)
      @pages.key?(slug.to_s)
    end

    def pages
      @pages.values
    end

    # Only resources are cleared: they are reloadable host-app classes that
    # re-register on every `to_prepare`. Pages ship with the gem, so they
    # register once at require-time and would never come back.
    def clear
      @resources.clear
    end
  end
end
