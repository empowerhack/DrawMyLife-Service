FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test+#{n}@example.com" }
    password 'my53cur3pa55word'
    password_confirmation 'my53cur3pa55word'
    country "GR"
  end
end
