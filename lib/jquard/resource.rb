module Jquard
  class Resource
    class << self
      attr_writer :model

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
    end
  end
end
