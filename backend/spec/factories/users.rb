FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    supabase_uid { Faker::Internet.uuid }
  end
end
