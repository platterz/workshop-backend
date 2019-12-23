# frozen_string_literal: true

class Types::RestaurantProductType < Types::BaseObject
  field :id, ID, null: false
  field :item, String, null: false
  field :price, Numeric, null: false
  field :restaurant, Types::RestaurantType, null: false
end
