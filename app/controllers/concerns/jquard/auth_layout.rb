module Jquard
  module AuthLayout
    extend ActiveSupport::Concern

    included do
      layout "jquard/auth"
      helper Jquard::Engine.helpers
      prepend_view_path Jquard::Engine.root.join("app/views")
    end
  end
end
