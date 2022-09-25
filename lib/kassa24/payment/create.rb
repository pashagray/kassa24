module Kassa24
  module Payment
    class Create
      ENDPOINT = "https://ecommerce.pult24.kz/payment/create".freeze
      REQUIRED_FIELDS = %i[
        amount
      ].freeze

      ADDITIONAL_FIELDS = %i[
        callback_url
        customer_data
        demo
        description
        fail_url
        metadata
        order_id
        success_url
      ].freeze

      AVAILABLE_FIELDS = (REQUIRED_FIELDS + ADDITIONAL_FIELDS).freeze

      def call(login:, password:, **params)
        missing_fields = REQUIRED_FIELDS - params.keys
        raise ArgumentError, "Missing required fields #{missing_fields}" unless missing_fields.empty?
        raise ArgumentError, "Unknown fields #{params.keys - AVAILABLE_FIELDS}" unless (params.keys - AVAILABLE_FIELDS).empty?

        Kassa24::Request.new(
          login: login,
          password: password,
          url: ENDPOINT,
          params: params.merge(merchant_id: login)
        ).call
      end
    end
  end
end
