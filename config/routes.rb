Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "pages#home"
  get 'profile', to: 'pages#profile'
  get '/disponibilites', to: 'bookings#disponibilites'
  get '/landing_reservation/:token', to: 'bookings#landing_reservation', as: 'landing_reservation'
  get '/choose_reservation/:token', to: 'bookings#choose_reservation', as: 'choose_reservation'
  get '/finish_reservation_exist/:token', to: 'bookings#finish_reservation_exist', as: 'finish_reservation_exist'
  get '/finish_reservation_missing/:token', to: 'bookings#finish_reservation_missing', as: 'finish_reservation_missing'


  resources :bookings do  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    member do
      put :confirm
      put :refuse
    end
  end
  resources :clients
  resources :formules
  resources :packages

  # Defines the root path route ("/")
  # root "articles#index"
end
