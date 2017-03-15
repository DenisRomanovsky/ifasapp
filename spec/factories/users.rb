FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    #encrypted_password { Faker::Lorem.word }
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
    user_info { FactoryGirl.create(:user_info) }
  end
end