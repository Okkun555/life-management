FactoryBot.define do
  factory :profile do
    birthday { Date.new(1990, 1, 1) }
    sex { 1 }
    is_public { true }

    association :user
  end
end
