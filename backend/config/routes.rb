Rails.application.routes.draw do
  namespace :api do
    resources :mission_statement, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
