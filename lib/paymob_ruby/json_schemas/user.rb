module PaymobRuby
  module JsonSchemas
    module User
      extend ActiveSupport::Concern

      def user_valid?
        JSON::Validator.validate!(customer_schema, @user)
      rescue JSON::Schema::ValidationError => e
        raise InvalidRequestError.new("Customer hash has the following error: #{e.message}", :user)
      end

      private

      def customer_schema
        {
          type: "object",
          "$schema": "http://json-schema.org/draft-04/schema",
          properties: {
            first_name: { type: "string" },
            last_name: { type: "string" },
            email: { type: "string" },
            phone_number: { type: "string" }
          },
          required: %w[first_name last_name email phone_number]
        }
      end
    end
  end
end