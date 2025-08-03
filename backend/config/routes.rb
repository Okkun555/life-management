Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: [:index, :show, :today_todo_list] do
      # TODO: moduleを利用してcontrollerの位置をtodo_lists/todo_list_items_controller.rbにする
      resources :todo_list_items, only: [:create, :update, :destroy] do
        resource :status, only: [:update], controller: 'todo_list_item_statuses'
      end

      resource :todo_review, only: [:create, :update]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
