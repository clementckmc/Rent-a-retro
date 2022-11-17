# @format

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :games, only: %i[index show]

  resources :offers, only: %i[new create] do
    resources :rentals, only: [:create]
  end

  namespace :user do
    get "profile", to: "profile#show", as: :profile
    resources :rentals, only: %i[index update]
    resources :offers, only: :index
  end
end
