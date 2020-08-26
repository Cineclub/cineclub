Rails.application.routes.draw do
  resources :teams do
    member do
      patch 'join'
      patch 'leave'
    end
  end
  resources :users, controller: :users, only: :create
  root to: 'home#show'
end
