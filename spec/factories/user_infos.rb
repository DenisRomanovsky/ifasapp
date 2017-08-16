# frozen_string_literal: true

# == Schema Information
#
# Table name: user_infos
#
#  id                :integer          not null, primary key
#  first_name        :string
#  last_name         :string
#  phone_number      :string
#  city_id           :integer
#  user_status_cd    :integer
#  created_at        :datetime
#  updated_at        :datetime
#  send_email        :boolean          default(TRUE)
#  organization_name :string
#

FactoryGirl.define do
  factory :user_info do
    first_name { Faker::LordOfTheRings.character }
    last_name { Faker::LordOfTheRings.character }
    phone_number { Faker::PhoneNumber.cell_phone }
    city_id { FactoryGirl.create(:city).id }
  end
end
