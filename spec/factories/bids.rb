# frozen_string_literal: true

FactoryGirl.define do
  factory :bid do
    price { Faker::Number.number(5) }
    description { Faker::Lorem.paragraph }
    status :active
  end
end
