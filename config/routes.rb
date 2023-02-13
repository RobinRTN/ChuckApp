Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "pages#home"
  get 'profile', to: 'pages#profile'
  get 'cours', to: 'pages#cours'
  get 'packages', to: 'pages#cours'
  resources :bookings  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :clients  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
