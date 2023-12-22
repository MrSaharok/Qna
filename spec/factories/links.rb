FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { 'http://www.glebkaif.ru/'}

    trait :linkable do
      association :linkable, factory: :answer
    end

    trait :valid_gist do
      url { 'https://gist.github.com/MrSaharok/7e2f4bb9567fd10d5cb2a87a09ef875d' }
    end

    trait :invalid_gist do
      url { 'https://gist.github.com/MrSaharok/' }
    end
  end
end