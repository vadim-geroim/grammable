FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "dummyEmail#{n}@1.com" }
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :gram do
    message { "hello" }
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png').to_s, 'image/png') }
    association :user
  end
end