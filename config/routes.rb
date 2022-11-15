Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :games, only: [:index, :show]

  resources :offers, only: [:new, :create] do
    resources :rentals, only: [:create]
  end

  namespace :owner do
    resources :rentals, only: :index
  end

  resources :rentals, only: [:update, :index]
end
