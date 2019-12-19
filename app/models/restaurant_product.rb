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

class RestaurantProduct < ApplicationRecord
  belongs_to :restaurant, inverse_of: :restaurant_products

  validates :item, :price, :restaurant, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
