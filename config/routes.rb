Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  resources :apartments do
    get 'search', on: :collection
  end

  resources :bookings
end
