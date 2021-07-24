Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transfers, only: :create
    end
  end

  resources :users, only: :index

  root to: 'users#index'
end
