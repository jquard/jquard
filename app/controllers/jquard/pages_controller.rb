module Jquard
  class PagesController < ApplicationController
    def show
      page_class = Jquard.registry.fetch_page(params[:page_slug]) do
        raise ActionController::RoutingError,
          "No Jquard page registered for #{params[:page_slug].inspect}"
      end

      @page = page_class.new
      render @page.component
    end
  end
end
