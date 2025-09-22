FactoryBot.define do
  factory :mission_statement_value do
    content { '趣味が多い人だった' }

    association :author, factory: :user
  end
end
