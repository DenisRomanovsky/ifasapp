FactoryGirl.define do
  factory :mechanism_subcategory do
    sequence(:description) { |n| Faker::Lorem.word + n.to_s }
  end
end