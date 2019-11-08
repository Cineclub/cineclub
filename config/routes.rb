Rails.application.routes.draw do
  require 'sidekiq/web'

  constraints Clearance::Constraints::SignedIn.new do
    mount Sidekiq::Web, at: "/sidekiq", as: :sidekiq
  end

  resources :users, controller: :users, only: :create
  root to: 'home#show'
end
