FactoryGirl.define do
  factory :mechanism_category do
    sequence(:description) { |n| Faker::Lorem.sentence + n.to_s }
    sequence(:home_description) { |n| Faker::Lorem.sentence + n.to_s }

    trait :with_subcats do
      after :create do |cat|
        3.times do
          FactoryGirl.create(:mechanism_subcategory, mechanism_category: cat)
        end
      end
    end
  end
end