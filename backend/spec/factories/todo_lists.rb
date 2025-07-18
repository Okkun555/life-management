FactoryBot.define do
  factory :todo_list do
    title { '2025-07-18' }
    is_current { true }

    association :author, factory: :user
  end
end
