Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  references :users do
    references :offers, only: [:show, :new, :create, :edit, :update]
  end

  references :offers, only: [:destroy]
end
