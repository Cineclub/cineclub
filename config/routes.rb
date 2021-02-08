Rails.application.routes.draw do
  resources :teams do
    member do
      patch 'join'
      patch 'leave'
    end
  end

  resources :users, controller: :users, only: :create

  get "/confirm_email" => "email_confirmations#edit", as: "confirm_email"
  put "/confirm_email" => "email_confirmations#update"

  resources :teams, only: [] do
    resources :rounds, only: [:create]
  end

  resources :rounds, only: [:show] do
    resources :screenings, only: [:create]
  end

  resources :screenings, only: [:destroy]

  root to: 'home#show'
end
