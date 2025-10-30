Rails.application.routes.draw do
  namespace :api do
    resource :user, only: [:show]
    resource :profile, only: [:show, :create, :update]

    resources :todo_lists, only: [:index, :show, :create] do
      collection do
        get :latest
      end
      scope module: :todo_lists do
        resources :todo_list_items, only: [:create, :update, :destroy] do
          resource :status, only: [:update], controller: 'todo_list_item_statuses'
        end
        resource :todo_review, only: [:create, :update]
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
