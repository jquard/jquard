module Jquard
  class ResourcesController < ApplicationController
    before_action :set_resource, except: :root

    def root
      first = Jquard.registry.resources.min_by { |resource| [ resource.navigation_sort, resource.navigation_label ] }

      if first
        redirect_to resource_path(first.slug)
      else
        render plain: "No Jquard resources registered. Run `bin/rails generate jquard:resource YourModel`."
      end
    end

    def index
      @records = @resource.model.all
    end

    private

    def set_resource
      @resource = Jquard.registry.fetch(params[:resource_slug]) do
        raise ActionController::RoutingError,
          "No Jquard resource registered for #{params[:resource_slug].inspect}"
      end
    end
  end
end
