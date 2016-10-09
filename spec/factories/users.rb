FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test+#{n}@example.com" }
    password 'my53cur3pa55word'
    password_confirmation 'my53cur3pa55word'
    country "GR"
    role "admin"

    organisation

    trait :admin do
      role "admin"
    end

    trait :org_admin do
      role "org_admin"
    end

    trait :super_admin do
      role "super_admin"
    end
  end
end
