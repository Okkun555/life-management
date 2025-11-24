FactoryBot.define do
  factory :body_part do
    name { '胸' }
    ancestry { nil }
    association :user

    # 子階層のデータ
    # 上半身-胸
    trait :child do
      name { '胸' }

      transient do
        parent_name { '上半身' }
      end

      after(:build) do |body_part, evaluator|
        parent = create(:body_part, :parent, name: evaluator.parent_name, user: body_part.user)
        body_part.parent = parent
      end
    end

    # 孫階層のデータ
    # 上半身-胸-大胸筋上部
    trait :grandchild do
      name { '大胸筋上部' }

      transient do
        grand_parent_name { '上半身' }
        parent_name { '胸' }
      end

      after(:build) do |body_part, evaluator|
        grand_parent = create(:body_part, :parent, name: evaluator.grand_parent_name, user: body_part.user)
        parent = create(:body_part, name: evaluator.parent_name, parent: grand_parent, user: body_part.user)
        body_part.parent = parent
      end
    end
  end
end
