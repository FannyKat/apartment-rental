Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  get "up" => "rails/health#show", as: :rails_health_check

  root "apartments#index"

  resources :apartments do
    get 'search', on: :collection
  end

  resources :bookings do
    member do
      patch :accepted
      patch :rejected
      patch :pending
    end
  end

  resources :ownership_requests, only: [:create, :new]

  patch 'users/switch_role', to: 'users#switch_role', as: 'switch_role'

  resources :disputes
end
