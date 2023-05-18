Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  root to: "pages#home"
  get 'profile', to: 'pages#profile'
  get 'conditions', to: 'pages#conditions'
  get 'mentions', to: 'pages#mentions'
  get 'politique', to: 'pages#politique'
  get '/disponibilites', to: 'bookings#disponibilites', as: 'disponibilites'
  get '/landing_reservation/:token', to: 'bookings#landing_reservation', as: 'landing_reservation'
  get '/choose_reservation/:token', to: 'bookings#choose_reservation', as: 'choose_reservation'
  get '/finish_reservation/:token', to: 'bookings#finish_reservation', as: 'finish_reservation'
  patch '/update_availability/:id', to: 'bookings#update_availability', as: 'update_availability'

  get 'new_choose_reservation', to: 'bookings#new_choose_reservation', as: 'new_choose_reservation'
  get 'new_finish_reservation', to: 'bookings#new_finish_reservation', as: 'new_finish_reservation'


  get 'date_new_reservation', to: 'bookings#date_new_reservation', as: 'date_new_reservation'
  get 'date_new_finish_reservation', to: 'bookings#date_new_finish_reservation', as: 'date_new_finish_reservation'

  get 'onboarding/:step', to: 'onboarding#show', as: :onboarding
  patch 'onboarding/:step', to: 'onboarding#update'

  resources :users, only: [] do
    collection do
      get 'edit_info'
      patch 'update_info'
    end
  end

  resources :bookings do  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    member do
      put :confirm
      put :refuse
    end
  end
  resources :clients
  resources :formules
  resources :packages
  resources :groups

  # Defines the root path route ("/")
  # root "articles#index"
end
