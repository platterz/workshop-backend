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


require 'rails_helper'

RSpec.describe RestaurantProduct, type: :model do
  subject(:restaurant_product) { build(:restaurant_product) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without item name' do
    restaurant_product.item = nil
    should be_invalid
  end

  it 'is invalid without price' do
    restaurant_product.price = nil
    should be_invalid
  end

  it 'is invalid with negative price' do
    restaurant_product.price = -5
    should be_invalid
  end

  it 'is invalid without restaurant' do
    restaurant_product.restaurant = nil
    should be_invalid
  end
end
