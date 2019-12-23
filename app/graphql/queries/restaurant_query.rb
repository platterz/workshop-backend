# frozen_string_literal: true

class Queries::RestaurantQuery < Queries::BaseQuery
  field :restaurant, Types::RestaurantType, null: false
  field :errors, [Types::ValidationErrorType], null: false

  argument :id, ID, required: true

  def resolve(id:)
    { restaurant: Restaurant.find(id), errors: [] }
  end
end
