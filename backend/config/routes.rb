Rails.application.routes.draw do
  namespace :api do
    # アカウント関連
    resources :users, only: [] do
      collection do
        get :me
      end
    end
    resource :profile, only: [:show, :create, :update]

    # トレーニング記録関連
    resources :body_parts, only: [:index, :create, :destroy]

    # TODO:良きタイミングで以下のルーティングと紐づくコードを全て削除する
    # resources :todo_lists, only: [:index, :show, :create] do
    #   collection do
    #     get :latest
    #   end
    #   scope module: :todo_lists do
    #     resources :todo_list_items, only: [:create, :update, :destroy] do
    #       resource :status, only: [:update], controller: 'todo_list_item_statuses'
    #     end
    #     resource :todo_review, only: [:create, :update]
    #   end
    # end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
