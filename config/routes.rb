Rails.application.routes.draw do
  resources :users, controller: :users, only: :create
  root to: 'home#show'
end
