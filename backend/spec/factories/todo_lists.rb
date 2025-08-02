FactoryBot.define do
  factory :todo_list do
    title { Faker::Date.between(from: 10.days.ago, to: Time.zone.today).strftime('%Y/%m/%d') }
    is_current { true }

    association :author, factory: :user
  end
end
