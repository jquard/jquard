Jquard::Engine.routes.draw do
  root to: "resources#root"

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
