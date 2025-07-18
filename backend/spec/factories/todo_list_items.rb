FactoryBot.define do
  factory :todo_list_item do
    content { 'TODO内容' }
    status { :pending }

    association :author, factory: :user
    association :todo_list, factory: :todo_list
  end
end
