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

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject(:restaurant) { build(:restaurant) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without name' do
    restaurant.name = nil
    should be_invalid
  end

  it 'is invalid without price range' do
    restaurant.price_range = nil
    should be_invalid
  end

  it 'is invalid when price range is outside of acceptable range' do
    restaurant.price_range = 4
    should be_invalid
  end
end
