Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :photos
  resources :comments
  resources :likes, only: [:create, :destroy]
  resources :follow_requests, only: [:create, :destroy] do
    member do
      patch :accept
      patch :reject
    end
  end
  resources :users, only: [:index, :show]

  get "/feed", to: "photos#feed"
  get "/discovery", to: "photos#discovery"


  root "photos#index"
end
