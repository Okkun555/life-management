FactoryBot.define do
  factory :mission_statement_role do
    role { '父親' }

    association :author, factory: :user
  end
end
