FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "dummyEmail#{n}@1.com" }
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :gram do
    message { "hello" }
    association :user
  end
end