# frozen_string_literal: true
# == Schema Information
#
# Table name: auctions
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  start_time            :datetime
#  end_time              :datetime
#  description           :text
#  created_at            :datetime
#  updated_at            :datetime
#  mechanism_category_id :integer
#  status                :integer
#  delivery_included     :boolean
#  cash_payed            :boolean
#  with_tax              :boolean
#  user_email            :string
#


FactoryGirl.define do
  factory :auction do
    start_time Time.now - 10.minutes
    end_time Time.now + 10.minutes
    description { Faker::Lorem.paragraph }
    status :active
    delivery_included true
    cash_payed true
    with_tax true

    trait :with_subcats do
      mechanism_category

      after :create do |auction|
        3.times do
          subcat = FactoryGirl.create(:mechanism_subcategory, mechanism_category: auction.mechanism_category)
          auction.mechanism_subcategories << subcat
        end
        auction.save!
      end
    end
  end
end
