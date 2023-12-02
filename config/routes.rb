Rails.application.routes.draw do
  get 'reservations/index'
  get 'rooms/index'
  get 'rooms/new_room'
  get 'rooms/myroom_index'
  get 'rooms/show'
  get 'rooms/search'
  get 'users/index'
  get 'users/account'
  get 'users/signup'
  get 'users/edit'
  get 'users/edit_profile'
  get 'users/profile'
  get 'reservations/reservations'
  
  resources :rooms do
    resources :reservations 
      collection do
        get "search"
      end
  end

  resources :reservations do
    collection do
      post "confirm_create" 
    end 
  end

  resources :reservations, param: :id

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
  patch "edit_profile", to: "users#update_profile"
  get "rooms", to: "rooms#index"
  post "rooms", to: "rooms#create"
  get "myroom_index", to: "rooms#myroom_index"
  get "new", to: "rooms#new_room"
  get "show", to: "rooms#show"
  post "show", to: "rooms#create"
  get "reservations", to: "reservations#index"
  get "edit_reservation", to: "reservations#edit"
  patch "edit_reservation", to: "reservations#update"
  get "search", to: "rooms#search"

  root "top#index"
end
