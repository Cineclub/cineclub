Rails.application.routes.draw do
  resources :teams do
    member do
      patch 'join'
      patch 'leave'
    end
  end
  resources :users, controller: :users, only: :create
  resources :teams do
    resources :rounds, only: [:create]
  end
  resources :rounds, only: [:create, :show] do
    resources :screenings, only: [:create]
  end
  resources :screenings, only: [:destroy]

  root to: 'home#show'
end
