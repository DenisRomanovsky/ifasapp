# frozen_string_literal: true
# == Schema Information
#
# Table name: mechanisms
#
#  id                       :integer          not null, primary key
#  mechanism_category_id    :integer
#  mechanism_subcategory_id :integer
#  description              :string
#  long_description         :text
#  created_at               :datetime
#  updated_at               :datetime
#  user_id                  :integer
#


FactoryGirl.define do
  factory :mechanism do
    description { Faker::Lorem.sentence }
    long_description { Faker::Lorem.paragraph }
  end
end
