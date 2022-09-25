module Kassa24
  class Request
    def initialize(login:, password:, url:, params:)
      @conn = Faraday.new(
        url: url
      )
      @conn.request :authorization, :basic, login, password
      @params = params
    end

    def call
      response = @conn.post do |req|
        req.body = camelize_keys(@params).to_json
      end
      Result.new(response)
    end

    private

    def camelize_keys(params)
      params.transform_keys { |key| snake_case_to_camel_case(key.to_s) }
    end

    def snake_case_to_camel_case(string)
      string.split("_").map.with_index do |word, idx|
        idx.zero? ? word : word.capitalize
      end.join
    end
  end
end
