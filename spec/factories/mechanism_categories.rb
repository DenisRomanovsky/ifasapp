# frozen_string_literal: true

# == Schema Information
#
# Table name: mechanism_categories
#
#  id               :integer          not null, primary key
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  home_description :text
#  slug             :string
#

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
