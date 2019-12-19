# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurants
#
#  id                :bigint           not null, primary key
#  description       :string
#  image             :string
#  image_description :string
#  name              :string           not null
#  price_range       :integer          default(1), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'faker'

FactoryBot.define do
  factory :restaurant do
    name { Faker::Hipster.word }
    price_range { Faker::Number.between(1, 3) }

    transient do
      products_count { 0 }
    end

    trait :with_products do
      products_count { 1 }
    end

    after(:build) do |restaurant, e|
      restaurant.restaurant_products = build_list(:restaurant_product, e.products_count)
    end
  end
end
