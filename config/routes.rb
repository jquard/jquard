Jquard::Engine.routes.draw do
  root to: "pages#show", defaults: { page_slug: "dashboard" }

  # Evaluated per request, so it sees the registry as rebuilt by `to_prepare`.
  # Pages claim the first segment only for slugs they own; everything else
  # falls through to the resource routes below.
  get ":page_slug", to: "pages#show", as: :page,
      constraints: ->(request) { Jquard.registry.page?(request.params[:page_slug]) }

  # Fixed routes must be declared above this line: ":resource_slug" matches
  # any first segment, so anything below it would be unreachable.
  scope ":resource_slug" do
    get "/", to: "resources#index", as: :resource
    get "create", to: "resources#new", as: :new_resource
    post "/", to: "resources#create"
    get ":record_id/edit", to: "resources#edit", as: :edit_resource
    patch ":record_id", to: "resources#update", as: :resource_record
    put ":record_id", to: "resources#update"
    delete ":record_id", to: "resources#destroy"
  end
end
