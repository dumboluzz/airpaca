Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/login'
  # get 'sessions/welcome'
  devise_for :users
  root to: 'pages#home'
  resources :alpacas
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :alpacas, only: [:show] do
    resources :bookings, only: [:create]
  end

  resources :bookings, only: [:index] do
    get "accept", to: "bookings#accept"
    get "reject", to: "bookings#reject"
  end
end
