FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 6)
    name { Faker::Internet.username(specifier: 5..6) }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
    confirmed_at { Date.today }
  end
end
