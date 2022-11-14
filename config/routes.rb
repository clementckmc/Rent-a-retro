Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users do
    resources :offers, only: [:show, :new, :create, :edit, :update]
  end

  resources :offers, only: [:destroy]
end
