# frozen_string_literal: true
# == Schema Information
#
# Table name: mechanism_subcategories
#
#  id                    :integer          not null, primary key
#  description           :text
#  mechanism_category_id :integer
#  created_at            :datetime
#  updated_at            :datetime
#


FactoryGirl.define do
  factory :mechanism_subcategory do
    sequence(:description) { |n| Faker::Lorem.word + n.to_s }
  end
end
