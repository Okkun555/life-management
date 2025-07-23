Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: [:index] do
      resources :todo_list_items, only: [:create, :update, :destroy] do
        resource :status, only: [:update], controller: 'todo_list_item_statuses'
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
