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
end
