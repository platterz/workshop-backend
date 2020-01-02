# frozen_string_literal: true

class Types::RestaurantProductType < Types::BaseObject
  field :id, ID, null: false
  field :item, String, null: false
  field :price, Float, null: false
  field :restaurant, Types::RestaurantType, null: false
end
