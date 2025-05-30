Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "items#index"
  resources :items, only: [:index, :new, :create , :show, ]
  # resources :users, only: [:show] ← 必要ならendを付けて復活させてください
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  end