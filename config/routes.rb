Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :games, only: [:index, :show]

  resources :offers, only: [:new, :create] do
    resources :rentals, only: [:create]
  end

  namespace :user do
    get "profile", to: "user#show", as: :profile
    resources :rentals, only: :index
    resources :offers, only: :index
  end

  resources :rentals, only: [:update, :index]
end
