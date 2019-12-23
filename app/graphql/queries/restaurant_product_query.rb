# frozen_string_literal: true

class Queries::RestaurantProductQuery < Queries::BaseQuery
  field :restaurant_product, Types::RestaurantProductType, null: false
  field :errors, [Types::ValidationErrorType], null: false

  argument :id, ID, required: false

  def resolve(id:)
    { restaurant_product: RestaurantProduct.find(id), errors: [] }
  end
end
