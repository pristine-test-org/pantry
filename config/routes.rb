Rails.application.routes.draw do
  resource :session, only: %i[ new create destroy ]

  root "dashboard#show"

  resources :items, except: :destroy
  resources :suppliers, only: %i[ index show ]
  resources :orders, only: :index
  get "about", to: "pages#about"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
