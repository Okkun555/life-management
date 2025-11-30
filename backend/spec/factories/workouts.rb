FactoryBot.define do
  factory :workout do
    name { 'ベンチプレス' }
    description { 'ネガティブを重視して低レップで行う' }

    association :user
    association :body_part
  end
end
