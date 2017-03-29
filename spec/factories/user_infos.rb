FactoryGirl.define do
  factory :user_info do
    first_name { Faker::LordOfTheRings.character }
    last_name { Faker::LordOfTheRings.character }
    phone_number { Faker::PhoneNumber.cell_phone }
    city_id { FactoryGirl.create(:city).id }
  end
end