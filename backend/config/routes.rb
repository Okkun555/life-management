Rails.application.routes.draw do
  namespace :api do
    resources :todo_list, only: [:index] do
      resource :todo_list_item, only: [:create]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
