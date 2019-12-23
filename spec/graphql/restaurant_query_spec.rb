# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::RestaurantQuery, type: :graphql_query do
  let(:restaurant) { create(:restaurant) }
  subject(:query) { described_class.new(context: {}, object: nil, field: nil) }

  describe '#resolve' do
    it 'returns the specified restaurant' do
      expect(query.resolve(id: restaurant.id)).to eq(restaurant)
    end

    it 'returns record not found when specified restaurant does not exist' do
      expect { query.resolve(id: -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
