# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurant_products
#
#  id            :bigint           not null, primary key
#  item          :string           not null
#  price         :float            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint           not null
#
# Indexes
#
#  index_restaurant_products_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#


require 'faker'

FactoryBot.define do
  factory :restaurant_product do
    item { Faker::Hipster.word }
    price { Faker::Number.decimal(5, 2) }
    association :restaurant, strategy: :build
  end
end
