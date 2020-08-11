FactoryBot.define do
  factory :issue do
    association :reporter, factory: :user
    status { 'not-started' }

    trait :invalid do
      # association :reporter, factory: :user
      status { 'not-started' }
    end
  end
end
