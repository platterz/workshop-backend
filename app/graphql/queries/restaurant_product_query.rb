# frozen_string_literal: true

class Queries::RestaurantProductQuery < Queries::BaseQuery
  type Types::RestaurantProductType, null: false

  argument :id, ID, required: false

  def resolve(id:)
    RestaurantProduct.find(id)
  end
end
