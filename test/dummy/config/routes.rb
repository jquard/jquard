Rails.application.routes.draw do
  devise_for :users

  mount Jquard::Engine => "/admin"

  root to: redirect("/admin")
end
