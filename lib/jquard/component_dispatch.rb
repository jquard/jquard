module Jquard
  module ComponentDispatch
    def component_class
      "#{self.class.name}Component".constantize
    end
  end
end
