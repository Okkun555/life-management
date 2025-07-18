FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    supabase_uid { Faker::Internet.uuid }
  end
end
