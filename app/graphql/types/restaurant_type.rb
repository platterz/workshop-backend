# frozen_string_literal: true

class Types::RestaurantType < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :description, String, null: true
  field :image, String, null: true
  field :image_description, String, null: true
  field :price_range, Integer, null: false

  field :restaurant_products, [Types::RestaurantProductType], null: false
end
