FactoryBot.define do
  factory :profile do
    birthday { Date.new(1990, 1, 1) }
    sex { 1 }
    is_public { true }

    association :user

    trait :with_avatar do
      after :build do |profile|
        profile.avatar.attach(
          io: Rails.root.join('spec/fixtures/files/sample_avatar.jpg').open,
          filename: 'sample_avatar.jpg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
end
