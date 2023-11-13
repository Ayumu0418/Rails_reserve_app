Rails.application.routes.draw do
  get 'reservations/index'
  get 'rooms/index'
  get 'users/index'
  get 'users/account'
  get 'users/signup'
  get 'users/edit'
  get 'users/edit_profile'
  get 'users/profile'
  

  get "signup", to: "signup#new"
  post "signup", to: "signup#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  delete "logout", to: "sessions#destroy"

  get "edit", to: "users#edit"
  patch "edit", to: "users#update"

  get "account", to: "users#account"
  get "profile", to: "users#profile"

  get "edit_profile", to: "users#edit_profile"
  patch 'edit_profile', to: "users#update_profile"

  root 'top#index'
end
