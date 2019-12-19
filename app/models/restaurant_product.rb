# == Schema Information
#
# Table name: restaurant_products
#
#  id             :bigint           not null, primary key
#  item           :string           not null
#  price          :float            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  restaurants_id :bigint           not null
#
# Indexes
#
#  index_restaurant_products_on_restaurants_id  (restaurants_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurants_id => restaurants.id)
#

class RestaurantProduct < ApplicationRecord
end
