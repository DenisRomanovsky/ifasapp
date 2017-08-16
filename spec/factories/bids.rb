# frozen_string_literal: true

# == Schema Information
#
# Table name: bids
#
#  id           :integer          not null, primary key
#  price        :float
#  description  :text
#  user_id      :integer
#  auction_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#  status       :integer          default(0)
#  mechanism_id :integer
#

FactoryGirl.define do
  factory :bid do
    price { Faker::Number.number(5) }
    description { Faker::Lorem.paragraph }
    status :active
  end
end
