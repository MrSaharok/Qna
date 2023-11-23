FactoryBot.define do
  factory :answer do
    body { "MyText" }
    question { nil }

    trait :invalid do
      title { nil }
    end
  end
end
