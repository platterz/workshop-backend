# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::RestaurantsQuery, type: :graphql_query do
  let(:restaurant) { create(:restaurant) }
  subject(:query) { described_class.new(context: {}, object: nil, field: nil) }

  it 'returns all restaurants' do
    expect(query.resolve).to eq([restaurant])
  end
end
