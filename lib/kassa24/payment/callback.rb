module Kassa24
  module Payment
    class Callback
      IP_WHITELIST = %w[
        35.157.105.64
      ].freeze

      def call(ip:, **params)
        raise Error, "Bad IP address #{ip}" unless IP_WHITELIST.include?(ip)

        symbolize_names(snakeize_keys(params))
      end

      private

      def symbolize_names(params)
        params.transform_keys(&:to_sym)
      end

      def snakeize_keys(params)
        params.transform_keys { |key| camel_case_to_snake_case(key.to_s) }
      end

      def camel_case_to_snake_case(string)
        string.gsub(/(.)([A-Z])/, '\1_\2').downcase
      end
    end
  end
end
