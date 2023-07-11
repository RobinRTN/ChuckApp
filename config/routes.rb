Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
  end
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
  get '/choose_reservation/:token', to: 'bookings#choose_reservation', as: 'choose_reservation'
  get '/finish_reservation/:token', to: 'bookings#finish_reservation', as: 'finish_reservation'
  patch '/update_availability/:id', to: 'bookings#update_availability', as: 'update_availability'

  post '/users/finish_onboarding', to: 'users#finish_onboarding'


  get 'new_choose_reservation', to: 'bookings#new_choose_reservation', as: 'new_choose_reservation'
  get 'new_finish_reservation', to: 'bookings#new_finish_reservation', as: 'new_finish_reservation'


  get 'date_new_reservation', to: 'bookings#date_new_reservation', as: 'date_new_reservation'
  get 'date_new_finish_reservation', to: 'bookings#date_new_finish_reservation', as: 'date_new_finish_reservation'

  get 'client_new_reservation', to: 'bookings#client_new_reservation', as: 'client_new_reservation'
  get 'client_new_finish_reservation', to: 'bookings#client_new_finish_reservation', as: 'client_new_finish_reservation'
  get 'client_confirm_reservation', to: 'bookings#client_confirm_reservation', as: 'client_confirm_reservation'
  patch 'update_time/:id', to: 'bookings#update_time', as: 'update_time'


  get 'onboarding/:step', to: 'onboarding#show', as: :onboarding
  patch 'onboarding/:step', to: 'onboarding#update'

  put '/clients/:id/update_note', to: 'clients#update_note', as: :update_note
  delete 'clients/:id/erase', to: 'clients#erase', as: 'erase_client'

  resources :users, only: [] do
    collection do
      get 'edit_info'
      patch 'update_info'
      get 'edit_dispo'
      patch 'update_dispo'
      get 'edit_indispo'
      patch 'update_indispo'
      get 'delete_gallery'
      post 'add_gallery'
      get 'edit_formules'
      patch 'update_formules'
      post 'update_profile_picture'
    end
  end

  resources :bookings do  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    member do
      put :confirm
      put :refuse
      get 'edit_schedule'
    end
  end

  put '/cancel_booking/:cancellation_token', to: 'bookings#cancel', as: 'cancel_booking'
  get '/confirm_cancel/:cancellation_token', to: 'bookings#confirm_cancel', as: 'confirm_cancel_booking'


  resources :clients
  resources :formules
  resources :groups

  # Defines the root path route ("/")
  # root "articles#index"
  get '/:token', to: 'bookings#landing_reservation', as: 'landing_reservation'
end
