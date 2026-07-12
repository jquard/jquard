Jquard::Engine.routes.draw do
  # Fixed routes must be declared above this line: ":resource_slug" matches
  # any first segment, so anything below it would be unreachable.
  get ":resource_slug", to: "resources#index", as: :resource
end
