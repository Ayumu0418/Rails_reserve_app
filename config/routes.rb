Rails.application.routes.draw do
  get 'reservations/index'
  get 'rooms/index'
  get 'users/index'
  get 'users/signup'

  get "signup", to: "signup#new"
  post "signup", to: "signup#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  delete "logout", to: "sessions#destroy"

  root 'top#index'
end
