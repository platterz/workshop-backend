# frozen_string_literal: true

class WorkshopSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  instrument(:field, ErrorHandlingInstrumentation.new)
end
