FactoryBot.define do
  factory :mission_statement_goal do
    goal { '趣味が多い人になる' }

    association :author, factory: :user
    association :role, factory: :mission_statement_role
  end
end
