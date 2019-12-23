# frozen_string_literal: true

class Queries::RestaurantQuery < Queries::BaseQuery
  type Types::RestaurantType, null: true

  argument :id, ID, required: true

  def resolve(id:)
    Restaurant.find(id)
  end
end
