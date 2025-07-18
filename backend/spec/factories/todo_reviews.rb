FactoryBot.define do
  factory :todo_review do
    review { '振り返りコメント' }

    association :author, factory: :user
    association :todo_list, factory: :todo_list
  end
end
