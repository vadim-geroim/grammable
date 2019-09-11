FactoryBot.define do
  factory :user do
    sequence :email do |n|
        "dummyEmail#{n}@1.com" 
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end
end