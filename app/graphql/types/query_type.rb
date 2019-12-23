# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :restaurant, resolver: Queries::Restaurant
    field :restaurants, resolver: Queries::RestaurantQuery

    field :restaurant_product, resolver: Queries::RestaurantProductQuery
  end
end
