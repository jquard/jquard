Rails.application.routes.draw do
  devise_for :users

  mount Jquard::Engine => "/admin"
end
