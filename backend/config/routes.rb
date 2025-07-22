Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: [:index] do
      resources :todo_list_items, only: [:create, :update]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
