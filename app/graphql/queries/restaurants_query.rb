# frozen_string_literal: true

class Queries::RestaurantsQuery < Queries::BaseQuery
  type Types::RestaurantType.connection_type, null: false

  argument :restaurant_query, String, required: false, description: 'Search restaurant name and description'
  argument :product_query, String, required: false, description: 'Search restaurants by product names'

  def resolve(query: nil, product_query: nil)
    scope = Restaurant.all
    scope = scope.search(query) if query.present?
    scope = scope.search_by_product if product_query.present?
    scope
  end
end
