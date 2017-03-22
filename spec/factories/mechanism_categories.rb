FactoryGirl.define do
  factory :mechanism_category do
    sequence(:description) { |n| Faker::Lorem.word + n.to_s }
    home_description { Faker::Lorem.word }

    trait :with_subcats do
      after :create do |cat|
        3.times do
          FactoryGirl.create(:mechanism_subcategory, mechanism_category: cat)
        end
      end
    end
  end
end