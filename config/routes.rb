Rails.application.routes.draw do
  root to: "users#index"

  devise_for :users, controllers: { registrations: "users/registrations" }

  # Users
  resources :users, only: [:index, :show], param: :username do
    member do
      get :feed
      get :liked_photos
      get :discover
    end
  end

  # Photos
  resources :photos, only: [:index, :show, :create, :update, :destroy]

  # Follow Requests
  resources :follow_requests, only: [:index, :create, :update, :destroy]

  # Likes
  resources :likes, only: [:index, :create, :destroy]

  # Comments
  resources :comments, only: [:index, :create, :destroy]
end
