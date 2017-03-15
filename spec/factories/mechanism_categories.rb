FactoryGirl.define do
  factory :mechanism_category do
    description { Faker::Lorem.word }
    home_description { Faker::Lorem.word }
  end
end