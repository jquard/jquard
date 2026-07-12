module Jquard
  class ResourcesController < ApplicationController
    before_action :set_resource

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
