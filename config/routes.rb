Rails.application.routes.draw do
  root to: "users#index"

  # Devise Authentication
  devise_for :users, controllers: {
  registrations: "users/registrations"
}

  # Users Routes
  resources :users, only: [:index, :show]

  # Photos
  resources :photos, only: [:index, :show, :create, :update, :destroy]

  # Follow Requests
  resources :follow_requests, only: [:index, :create, :update, :destroy]

  resources :comments, only: [:index, :create, :destroy]
  
  resources :likes, only: [:index, :create, :destroy]


  # This line is redundant if you're already using `resources :users, only: [:show]`
  # get("/users/:id", { controller: "users", action: "show" }) 
end
