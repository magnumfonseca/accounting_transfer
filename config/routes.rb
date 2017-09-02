Rails.application.routes.draw do
  root to: "sessions#new"

  namespace :api do
    namespace :v1 do
      resources :trades, only:  :create
      resources :deposits, only: :create
      resources :balance, only: :show
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :accounts, only: [:show]
end
