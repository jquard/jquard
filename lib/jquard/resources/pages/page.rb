module Jquard
  module Resources
    module Pages
      class Page
        # CreatePost lives in Jquard::Resources::Posts::Pages, so the owning
        # resource can be derived from the grandparent namespace: Posts → PostResource.
        def self.inferred_resource
          namespace = module_parent.module_parent
          namespace.const_get("#{namespace.name.demodulize.singularize}Resource")
        end

        attr_reader :resource

        def initialize(resource: nil)
          @resource = resource || self.class.inferred_resource
        end
      end
    end
  end
end
