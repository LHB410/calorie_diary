Rails.application.routes.draw do
  root "dashboard#index"

  resources :dashboard, only: [ :index ]
  resources :meals
  resources :foods, only: [ :index ] do
    collection do
      get :search
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
