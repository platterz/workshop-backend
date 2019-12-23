# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurants
#
#  id                :bigint           not null, primary key
#  description       :string
#  image             :string
#  image_description :string
#  name              :string           not null
#  price_range       :integer          default(1), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Restaurant < ApplicationRecord
  has_many :restaurant_products, inverse_of: :restaurant, dependent: :destroy

  validates :name, presence: true
  validates :price_range, inclusion: { in: 1..3 }

  scope :search, -> (query) {
    sanitized_query = "%#{sanitize_sql_like(query)}%"
    where(arel_table[:name].matches(sanitized_query))
      .or(where(arel_table[:description].matches(sanitized_query)))
  }

  scope :search_by_product, -> (query) {
    sanitized_query = "%#{sanitize_sql_like(query)}%"
    product_query = RestaurantProduct.where(RestaurantProduct.arel_table[:restaurant_id].eq(arel_table[:id]))
                                     .where(RestaurantProduct.arel_table[:item].matches(sanitized_query))

    where(product_query.arel.exists)
  }
end
