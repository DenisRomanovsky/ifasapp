FactoryGirl.define do
  factory :city do
    name { Faker::LordOfTheRings.location }
  end
end