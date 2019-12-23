# frozen_string_literal: true

class Types::ValidationErrorType < Types::BaseObject
  ObjectWrapper = Struct.new(:attribute, :errors, :mapped_attribute)

  field :attribute, String, null: false
  field :messages, [String], null: false do
    argument :long, Boolean, required: false, default_value: false do
      description 'Determines whether the `attribute` name should be included as part of the message.'
    end
  end

  def self.wrap(errors)
    errors.keys.map { |attribute_name| ObjectWrapper.new(attribute_name, errors) }
  end

  def attribute
    (object.mapped_attribute || object.attribute).to_s.camelize(:lower)
  end

  def messages(long:)
    long ? full_messages : object.errors[object.attribute]
  end

  # NOTE: This is an experimental change to only display actual attribute name for nested attributes
  # For example, instead of: "Offering unit groups[0] units[1] dish tags can't be blank"
  # We want to display "Dish tags can't be blank"
  # Additionally, base attribute is not appended to error messages
  def full_messages
    errors = object.errors[object.attribute]
    full_error_key = object.mapped_attribute || object.attribute
    error_attribute = full_error_key.to_s.split('.').last
    errors.map do |error|
      append_attribute_name?(attribute) ? error : "#{error_attribute.to_s.titleize} #{error}"
    end
  end

  def append_attribute_name?(attribute)
    attribute.blank? || /base/i.match?(attribute)
  end
end
