# frozen_string_literal: true

class Queries::RestaurantsQuery < Queries::BasicObject
  field :restaurants, [Types::RestaurantType], null: false
  field :errors, [Types::ValidationErrorType], null: false

  argument :restaurant_query, String, required: false, description: 'Search restaurant name and description'
  argument :product_query, String, required: false, description: 'Search restaurants by product names'

  def resolve(query:, product_query:)
    scope = Restaurant.all
    scope = scope.search(query) if query.present?
    scope = scope.search_by_product if product_query.present?

    { restaurants: scope, errors: [] }
  end
end
