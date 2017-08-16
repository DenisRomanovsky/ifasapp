# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :string
#

FactoryGirl.define do
  factory :city do
    name { Faker::LordOfTheRings.location }
  end
end
