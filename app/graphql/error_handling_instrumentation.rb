# frozen_string_literal: true

# Wraps queries, mutations, and fields in generic error handling.
# This catches certain types of errors and raises GraphQL::ExecutionErrors, which GraphQL-Ruby handles gracefully.
# Instead of crashing in the controller and serving a 500, meaningful errors are returning regarding a failure.
class ErrorHandlingInstrumentation
  def instrument(_type, field)
    # The +resolver_proc+ is what's resposible for producing a value from a requested field.
    # We wrap the existing one with an error handler, and replace the one defined on the type with the wrapper.
    old_resolve_proc = field.resolve_proc
    new_resolve_proc = proc { |object, arguments, context|
      begin
        old_resolve_proc.call(object, arguments, context)
      rescue ActiveRecord::RecordNotFound => error
        handle_not_found_error(error)
      end
    }

    field.redefine { resolve(new_resolve_proc) }
  end

private

  def handle_not_found_error(error)
    raise_graphql_error!("Couldn't find requested #{error.model}", 'Not Found')
  end

  def handle_not_authorized_error(error, context)
    action  = error.query.to_s.chomp('?')
    subject = error.record.is_a?(Class) ? error.record.name.pluralize : "this #{error.record.class.name}"
    code    = context[:current_resource_owner].nil? ? 'Unauthorized' : 'Forbidden'

    raise_graphql_error!("Not authorized to #{action} #{subject}", code)
  end

  def raise_graphql_error!(message, code)
    raise GraphQL::ExecutionError.new(message, extensions: { 'code' => code })
  end
end
