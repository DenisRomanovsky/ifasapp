# frozen_string_literal: true

FactoryGirl.define do
  factory :mechanism do
    description { Faker::Lorem.sentence }
    long_description { Faker::Lorem.paragraph }
  end
end
