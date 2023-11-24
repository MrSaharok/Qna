FactoryBot.define do
  sequence :body do |n|
    "MyText #{n}"
  end

  factory :answer do
    body { "MyText" }
    question
    user

    trait :invalid do
      body { nil }
      question
      user
    end
  end
end
