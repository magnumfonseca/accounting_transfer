Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :trades, only:  :create
      resources :deposit, only: :create
      resources :balance, only: :show
    end
  end
end
