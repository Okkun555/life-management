FactoryBot.define do
  factory :mission_statement_content do
    association :mission_statement
    content { '私の目標は、持続可能なwell-beingを追求することです。' }
  end
end
